function Base ()
{
  this.id = 'o' + Base.nextId++

  this.meta = { onchange    : []
              , destructors : []
              }

  this.$ = {}

  Base.all[this.id] = this
}

Base.nextId = 0
Base.all    = {}

addToProto(Base,

  function decorate (c /* constructor arguments */)
  {
    for (var m in c.prototype)
      if (m != "destructor")
        this[m] = c.prototype[m]

    if (c.prototype.destructor)
      this.meta.destructors.push(c.prototype.destructor)

    c.apply(this, [].slice.call(arguments, 1))
  },

  function destructor ()
  {
    this.meta.destructors.map(function (d) { d.call(this) }, this)
    foreach(this.$, function (p) { p.destructor() })
  },

  function def (name, init)
  {
    this.$[name] = new Property(this, name, init)
  },

  function derivedProp (name, init, constraint)
  {
    this.def(name, init)
    constraint.apply(null, [this[name].get()].concat([].slice.call(arguments, 3)))
  },

  function onchange (f)
  {
    this.meta.onchange.push(f)
  },

  function appEffects (v)
  {
    this.meta.onchange.map(function (o) { o.call(this, v) }, this)
  }

)

