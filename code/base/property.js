function Prop (o, n, v, c, t)
{
  this.obj      = o
  this.name     = n
  this.soft     = c
  this.type     = t || v.constructor.name
  this.value    = this.type == "Number" ? 1 * v : v
  this.triggers = {}
  this.busy     = false

  var self = this

  function get () { return self.value }

  function set (v)
  {
    v = this.type == "Number" ? 1 * v : v
    if (self.value == v) return
    if (self.busy) return
    self.busy = true
    self.value = v
    foreach(self.triggers, function (_, t) { t[1].app(t[0]) })
    self.obj.changed()
    self.busy = false
  }

  this.obj.__defineGetter__(this.name, get)
  this.obj.__defineSetter__(this.name, set)
  this.__defineGetter__("v", get)
  this.__defineSetter__("v", set)
}

Class(Prop,

  function destructor ()
  {
    for (var t in this.triggers) this.triggers[t][1].destructor()
    if (this.value.destructor) this.value.destructor()
  }

)

