function Base () { }

Base.nextId  = 0
Base.objects = {}

addToProto(Base,

  function baseInit ()
  {
    this.$ = { id          : Base.nextId++
             , properties  : {}
             , onchange    : []
             }
    Base.objects[this.$.id] = this
  },

  function countTriggers ()
  {
    var c = 0
    for (var p in this.$.properties)
      for (var t in this.$.properties[p].triggers)
        c++
    return c
  },

  function cleanup ()
  {
    for (var p in this.$.properties)
      this.$.properties[p].cleanup()
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

  function derivedProp (name, constraint)
  {
    this.property(name)
    constraint.apply(null, [this[name]].concat([].slice.call(arguments, 2)))
  }

)
