Module "base.Value"

Import "Prelude"

# Basic reactive value.

Class

  Value: (v) ->

    @value    = v
    @id       = Value.nextId++
    @effects  = {}
    @triggers = {}
    @reactors = {}
    @linked   = {}
    @busy     = false

    @__defineGetter__ "v", @get
    @__defineSetter__ "v", @set

  destructor: ->
    @value.destructor() if @value.destructor
    unlink @id for _, unlink of @linked
    return

  get: -> @value

  set: (v) ->
    return if @value == v or @busy
    @busy = true
    @value = v
    e     v for _, e of @effects
    r.set v for _, r of @reactors
    b.set v for _, b of @triggers
    @parent.changed [@name, v] if @parent
    @busy = false

Static

  # The Value smart constructor that build a reactive value when it not already
  # is reactive.

  val: (v) -> if v and v.constructor == Value then v else new Value v

  # Generic uni-directional lifting of plain JavaScript functions.

  ###
  lift: (f) -> (as...) ->
    r = new Value null
    r.linked.push a for a in as
    update = () -> r.v = f (a.v or a for a in as)...
    for i in [0..as.length - 1] when as[i].reactors
      as[i].reactors.push update
    update()
    r
  ###

  # Generic multi-directional lifting of plain JavaScript functions.

  constraint: (init, fs...) ->
    con = (as...) ->

      id = 'c' + Value.nextId++
      active = as.length

      mkU = (i) -> ->
        delete a.triggers[id] for a in as if --active < 2
        return

      mkT = (i) ->
        id: id
        linked: as
        triggers: as
        set: -> fs[i](as...)

      for i in [0..as.length - 1] when as[i].triggers
        as[i].linked[id]   = mkU i
        as[i].triggers[id] = mkT i

      fs[init](as...)

    # Add a helper function that exposes the constraint as a function that
    # computes and returns the first arguments.
    con.f = (as...) -> r = val null; con r, as...; r
    con

  init: -> Value.nextId = 0

