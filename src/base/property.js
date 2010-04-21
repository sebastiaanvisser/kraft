function Property (o, n, v)
{
  this.obj      = o
  this.name     = n
  this.value    = v
  this.triggers = {}
  this.busy     = false

  var self = this

  function get () { return self.value }

  function set (v)
  {
    if (self.value == v) return
    if (self.busy) return
    self.busy = true
    self.value = v
    foreach(self.triggers, function (t) { t[1].app(t[0]) })
    self.obj.changed()
    self.busy = false
  }

  this.obj.__defineGetter__(this.name, get)
  this.obj.__defineSetter__(this.name, set)
  this.__defineGetter__("v", get)
  this.__defineSetter__("v", set)
}

addToProto(Property,

  function destructor ()
  {
    for (var t in this.triggers) this.triggers[t][1].destructor()
    if (this.value.destructor) this.value.destructor()
  }

)

