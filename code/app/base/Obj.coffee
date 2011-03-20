Module "base.Obj"

Import "Prelude"
Import "base.Value"

Class

  Obj: (type, parent) ->
    @id      = (type || 'o') + Obj.nextId++
    @parent  = parent
    @classes = {}
    @$       = {}
    @meta    =
      onchange:     []
      constructors: []
      destructors:  []

    Obj.all[@id] = @
    @

  decorateOnly: (c) ->
    @[n] = f for n, f of c.prototype when n != "destructor"

    # Store the contructor and destructor.
    @meta.constructors.push c
    @meta.destructors.push c.prototype.destructor if c.prototype.destructor
    @

  decorate: (c, args...) ->
    @decorateOnly c
    c.call @, false, args...
    @

  revive: (c, args...) ->
    @decorateOnly c
    c.call @, true, args...
    @

  destructor: ->
    d.call @ for d in @meta.destructors
    p.destructor() for _, p of @$
    return

  identifier: -> (if @parent then @parent.identifier() else "") + '{' + @id + '}'

  Private
  defineProp: (p, name, init, constraint, args) ->
    # Setup property.
    @$[name] = new Value(init, @, name, !!constraint)

    # Install constraint when given any.
    if constraint
      constraint [if p then @$[name] else @[name]].concat(args)...

    # Propagate changes.
    if @[name].onchange
      @[name].onchange (v) =>
        v.push @[name]
        @changed v

    @$[name]

  define: (args...) -> @defineProp true,  args...
  derive: (args...) -> @defineProp false, args...

  onchange: (f) -> @meta.onchange.push(f)

  changed: (v) -> o.call(@, v) for o in @meta.onchange

Static

  init: ->
    Obj.classes = {}
    Obj.nextId  = 0
    Obj.all     = {}

  register: (ctor) -> Obj.classes[ctor.name] = ctor

