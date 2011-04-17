Module "base.Obj"

Import "Prelude"
Import "base.Value"

Class

  Obj: () ->
    @$    = {}
    @id   = Obj.nextId++
    @meta =
      constructors: []
      destructors:  []
      defined:      {}
      derived:      {}
      reactors:     []
    @

  destructor: ->
    d.call @ for d in @meta.destructors
    p.destructor() for _, p of @$ when p.destructor
    return

  decorate: (ctor, args...) ->

    # Decorate the current object.
    proto = ctor.prototype
    @[n] = f for n, f of proto when n != "destructor"

    # Store the constructor and destructor.
    @meta.constructors.push ctor
    @meta.destructors.push proto.destructor if proto.destructor

    # Call constructor.
    ctor.call @, args...
    @

  derive: (defs) -> @meta.derived[name] = @property name, v for name, v of defs; @

  define: (defs) ->
    for name, v of defs
      @meta.defined[name] = @property name, v
      (v.onchange (a...) => @changed a...) if v.onchange
    @

  Private
  property: (name, v) ->
    p = @$[name] = val v
    v.parent = p
    p.parent = @
    p.name = name
    @__defineGetter__ name,     -> p.get()
    @__defineSetter__ name, (v) -> p.set(v)
    p

  onchange: (f) -> @meta.reactors.push f
  changed: (args...) -> r.apply @, args.concat [@] for r in @meta.reactors

  path: -> if @parent and @parent.path then @parent.path() else ""

  debug: () ->
    indent = (s) -> ("  " + l for l in s.split /\n/).join "\n"
    res = (n + ": " + (if p.v.debug then "\n" + indent p.v.debug() else p.v) for n, p of @$)
    res.join "\n"

Static

  init: ->
    Obj.classes = {}
    Obj.nextId  = 0

  register: (ctor) ->
    Obj.classes[ctor.name] = ctor unless Obj.classes[ctor.name]

  mk: (ctor, args...) -> (new Obj ctor).decorate ctor, args...

