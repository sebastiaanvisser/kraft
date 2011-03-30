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

  id: ->
    ctor = @meta.constructors[0]
    name = ctor and ctor.name.replace /_Constructor$/, ''
    (name or "Anonymous") + @meta.id

  destructor: ->
    d.call @ for d in @meta.destructors
    p.destructor() for _, p of @$ when p.destructor

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

  define: (defs) -> @meta.defined[name] = @property name, v for name, v of defs; @
  derive: (defs) -> @meta.derived[name] = @property name, v for name, v of defs; @

  Private
  property: (name, v) ->
    p = @$[name] = val v
    p.parent = @
    p.name = name
    @__defineGetter__ name,     -> p.get()
    @__defineSetter__ name, (v) -> p.set(v)
    p

  onchange: (f) -> @meta.reactors.push f
  changed: (args...) -> r.apply @, args.concat [@] for r in @meta.reactors

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

