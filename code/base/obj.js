Module("base.Obj")

Import("Prelude")
Import("base.Value")

Class
(

  function Obj ()
  {
    this.id = 'o' + Obj.nextId++

    this.meta = { onchange     : []
                , constructors : []
                , destructors  : []
                }

    this.classes = {}
    this.$ = {}
    Obj.all[this.id] = this
  },

  function decorateOnly (c /* constructor arguments */)
  {
    for (var m in c.prototype)
      if (m != "destructor")
        this[m] = c.prototype[m]

    // Store the contructor and destructor.
    this.meta.constructors.push(c)
    if (c.prototype.destructor)
      this.meta.destructors.push(c.prototype.destructor)

  },

  function decorate (c, ctx /* constructors arguments */)
  {
    this.decorateOnly(c)
    c.apply(this, [false, ctx].concat([].slice.call(arguments, 2)))
  },

  function revive (c, ctx)
  {
    this.decorateOnly(c)
    c.apply(this, [true, ctx])
  },

  function destructor ()
  {
    this.meta.destructors.map(function (d) { d.call(this) }, this)
    foreach(this.$, function (_, p) { p.destructor() })
  },

  function defineProp (p, name, init, constraint, args)
  {
    // Setup property.
    this.$[name] = new Value(init, this, name, !!constraint)

    // Install constraint when given any.
    if (constraint) constraint.apply(null, [p ? this.$[name] : this[name]].concat(args))

    // Propagate changes.
    var me = this
    if (this[name].onchange) this[name].onchange(function (v) { v.push(me[name]); me.changed(v) })

    return this.$[name]
  },

  function define (n, i, c) { return this.defineProp(true,  n, i, c, slice(arguments, 3)) },
  function derive (n, i, c) { return this.defineProp(false, n, i, c, slice(arguments, 3)) },

  function onchange (f)
  {
    this.meta.onchange.push(f)
  },

  function changed (v)
  {
    this.meta.onchange.map(function (o) { o.call(this, v) }, this)
  }

)

Static
(

  function init ()
  {
    Obj.classes = {}
    Obj.nextId  = 0
    Obj.all     = {}
  },

  function register (ctor)
  {
    this.classes[ctor.name] = ctor
  }

)

