function Base ()
{
  this.id = 'o' + Base.nextId++

  this.meta = { onchange     : []
              , constructors : []
              , destructors  : []
              }

  this.classes = {}

  this.$ = {}

  Base.all[this.id] = this
}

Base.classes = {}
Base.nextId  = 0
Base.all     = {}

Static(Base,

  function register (ctor)
  {
    this.classes[ctor.name] = ctor
  }

)

Class(Base,

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

  function decorate (c /* constructors arguments */)
  {
    this.decorateOnly(c)
    c.apply(this, [].slice.call(arguments, 1))
  },

  function destructor ()
  {
    this.meta.destructors.map(function (d) { d.call(this) }, this)
    foreach(this.$, function (_, p) { p.destructor() })
  },

  function defineProp (p, name, type, init, constraint, args)
  {
    this.$[name] = new Prop(this, name, init, !!constraint, type)
    if (constraint) constraint.apply(null, [p ? this.$[name] : this[name]].concat(args))
  },

  function def  (n, i, c) { this.defineProp(true,  n, null, i, c, slice(arguments, 3)) },
  function def1 (n, i, c) { this.defineProp(false, n, null, i, c, slice(arguments, 3)) },
  function num  (n, i, c) { this.defineProp(true,  n, "number", i, c, slice(arguments, 3)) },

  function onchange (f)
  {
    this.meta.onchange.push(f)
  },

  function changed (v)
  {
    this.meta.onchange.map(function (o) { o.call(this, v) }, this)
  }

)

