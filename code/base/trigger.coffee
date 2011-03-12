Module "base.Trigger"

Class

  Trigger: (t, f, s) ->
    @id      = 't' + Trigger.nextId++
    @target  = [t, f]
    @sources = s

    # Register this trigger statically.
    Trigger.all[@id] = this
    @

  destructor: ->
    delete @target[0].triggers[@id]
    delete s[0].triggers[@id] for s in @sources
    return

  app: (side) ->
    vs = [@target[0].obj].concat (s[0].obj for s in @sources)
    if side
      tmp = s[1].apply(this, vs) for s in @sources
      s[0].v = s for s in tmp
    else @target[0].v = @target[1].apply(this, vs)
    return
 
Static

  init: ->
    Trigger.nextId = 0
    Trigger.all    = {}

  compose: (t, args...) ->

    # Build up trigger.
    s = ([args[i], args[i + 1]] for i in [0..args.length] by 2)
    trigger = new Trigger(t, f, s)

    # Install trigger.
    trigger.target[0].triggers[trigger.id] = [true, trigger]
    s[0].triggers[trigger.id] = [false, trigger] for s in trigger.sources

    trigger.app false

