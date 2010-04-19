function Base ()
{
    this.$ = { id          : Base.nextId++
             , properties  : {}
             , onchange    : []
             , destructors : []
             }
    Base.all[this.$.id] = this
}

Base.nextId = 0
Base.all    = {}

addToProto(Base,

  function decorate (klass /* constructor arguments */)
  {
    for (var m in klass.prototype)
      if (m != "destructor" && m != "constructor")
        this[m] = klass.prototype[m]

    if (klass.prototype.destructor)
      this.registerDestructor(klass.prototype.destructor)

    if (klass.prototype.constructor)
      klass.prototype.constructor.apply(this, [].slice.call(arguments, 1))

    klass.call(this)
  },

  function destructor ()
  {
    for (var i = 0; i < this.$.destructors.length; i++)
      this.$.destructors[i].call(this)

    for (var p in this.$.properties)
      this.$.properties[p].cleanup()
  },

  function registerDestructor (dtor)
  {
    this.$.destructors.push(dtor)
  },

  function onchange (f)
  {
    this.$.onchange.push(f)
  },

  function appEffects (v)
  {
    for (var i = 0; i < this.$.onchange.length; i++)
      this.$.onchange[i].call(this, v)
  },

  function property (name, init)
  {
    this[name] = new Property(this, name, init)
    this.$.properties[name] = this[name]
  },

  function derivedProp (name, init, constraint)
  {
    this.property(name, init)
    constraint.apply(null, [this[name].get()].concat([].slice.call(arguments, 3)))
  },

  function countTriggers ()
  {
    var c = 0
    for (var p in this.$.properties)
      for (var t in this.$.properties[p].triggers)
        c++
    return c
  }

)

