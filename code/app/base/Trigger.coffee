Module "base.Trigger"

Import "Prelude"

Class

  Trigger: (t, f, s) ->
    @id      = 't' + Trigger.nextId++
    @target  = [t, f]
    @sources = s

    Trigger.all[@id] = @
    @

  destructor: ->
    delete @target[0].triggers[@id]
    delete s[0].triggers[@id] for s in @sources

  app: (side) ->
    vs = ([@target[0].parent].concat (s[0].parent for s in @sources))
    if side
      computed = (s[1].apply(@, vs) for s in @sources)
      zip @sources, computed, (s, v) -> s[0].v = v
    else
      @target[0].v = @target[1].apply(@, vs)

Static

  init: ->
    Trigger.nextId = 0
    Trigger.all    = {}

  compose: (t, f, args...) ->

    # Build up trigger.
    s = ([args[i], args[i + 1]] for i in [0..args.length - 1] by 2)
    trigger = new Trigger(t, f, s)

    # Install trigger.
    trigger.target[0].triggers[trigger.id] = [true, trigger]
    s[0].triggers[trigger.id] = [false, trigger] for s in trigger.sources

    # Initialize the trigger by a first apply.
    trigger.app false

