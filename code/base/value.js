function Value (v, parent, name, soft, t)
{
  this.parent   = parent
  this.name     = name
  this.soft     = soft // Soft properties will not be serialized.
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
    if (self.parent) self.parent.changed([this])
    self.busy = false
  }

  if (this.parent)
  {
    this.parent.__defineGetter__(this.name, get)
    this.parent.__defineSetter__(this.name, set)
  }

  this.__defineGetter__("v", get)
  this.__defineSetter__("v", set)
}

function val (v)
{
  return (v && v.triggers) ? v : new Value(v);
}

Class(Value,

  function destructor ()
  {
    for (var t in this.triggers) this.triggers[t][1].destructor()
    if (this.value.destructor) this.value.destructor()
  }

)

