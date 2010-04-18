function Property (o, n, v)
{
  this.obj      = o
  this.name     = n
  this.value    = v
  this.busy     = false
  this.triggers = {}
}

Property.depth = 0

addToProto(Property,

  function cleanup ()
  {
    for (var t in this.triggers)
      this.triggers[t][1].cleanup()
  },

  function get () { return this.value },

  function set (v)
  {
    if (this.value == v) return
    if (this.busy) return
    this.busy = true
    Property.depth++

    this.value = v

    for (var t in this.triggers)
      this.triggers[t][1].app(this.triggers[t][0])

    this.obj.appEffects()

    Property.depth--
    this.busy = false
  }

)

