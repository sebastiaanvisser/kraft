Module "base.Value"

Import "Prelude"
Qualified "base.Transaction"

# Basic reactive value.

Class

  Value: (v) ->

    @value    = v
    @id       = Value.nextId++
    @effects  = {}
    @triggers = {}
    @reactors = {}
    @linked   = {}

    @__defineGetter__ "v", @get
    @__defineSetter__ "v", @set

  destructor: ->
    @value.destructor() if @value.destructor
    unlink @id for _, unlink of @linked
    return

  get: -> @value

  set: (v) ->
    return if @value == v
    Value.transaction.start @id, =>
      # console.log "set", @path(), "to", v
      @value = v
      r.set v, @id for _, r of @reactors
      b.set v, @id for _, b of @triggers
    Value.transaction.end @id, =>
      @parent.changed [@name, v] if @parent
      e v, @id for _, e of @effects
    Value.transaction.commit @id

  path: ->
    (if @parent and @parent.path then @parent.path() + "." else "") + (@name or "Value")

Static

  # The Value smart constructor that build a reactive value when it not already
  # is reactive.

  val: (v) -> if v and v.constructor == Value then v else new Value v

  # Generic multi-directional lifting of plain JavaScript functions.

  constraint: (name, init, fs...) ->
    con = (as...) ->

      id = name + '_' + Value.nextId++
      active = as.length

      mkUnlinker = (i) -> -> delete a.triggers[id] for a in as if --active < 2; return

      bs = {}
      bs[a.id] = a for a in as

      mkAction = (i) ->
        id: id
        linked: bs
        triggers: bs
        constraint: true
        set: ->
          Value.transaction.start id, =>
            # console.log "via", id
            fs[i](as...)
          Value.transaction.commit id

      for i in [0..as.length - 1] when as[i].triggers
        as[i].linked[id]   = mkUnlinker i
        as[i].triggers[id] = mkAction   i

      fs[init](as...)

    # Add a helper function that exposes the constraint as a function that
    # computes and returns the first arguments.
    con.f = (as...) -> r = val null; con r, as...; r
    con

  init: ->
    Value.nextId      = 0
    Value.transaction = new Transaction

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

