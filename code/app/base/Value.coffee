Module "base.Value"

Import "Prelude"

# Basic reactive value.

Class

  Value: (v) ->

    @value     = v
    @effects   = []
    @triggers  = []
    @reactors  = []
    @busy      = false

    @__defineGetter__ "v", @get
    @__defineSetter__ "v", @set

  destructor: ->
    @value.destructor() if @value.destructor
    # todo: unlink

  get: -> @value

  set: (v) ->
    return if @value == v or @busy
    @busy = true
    @value = v
    e v for e in @effects
    r v for r in @reactors
    b v for b in @triggers
    @parent.changed [@name, v] if @parent
    @busy = false

Static

  # The Value smart constructor that build a reactive value when it not already
  # is reactive.

  val: (v) -> if v and v.constructor == Value then v else new Value v

  # Generic uni-directional lifting of plain JavaScript functions.

  lift: (f) -> (as...) ->
    r = new Value(null)
    update = () -> r.v = f (a.v or a for a in as)...
    for i in [0..as.length - 1] when as[i].reactors
      as[i].reactors.push update
    update()
    r

  # Generic multi-directional lifting of plain JavaScript functions.

  constraint: (init, fs...) ->
    con = (as...) ->
      update = (i) -> -> fs[i](as...)
      for i in [0..as.length - 1] when as[i].triggers
        as[i].triggers.push (update i)
      fs[init](as...)

    # Add a helper function that exposes the constraint as a function that
    # computes and returns the first arguments.
    con.f = (as...) ->
      r = val null
      con r, as...
      r

    con

