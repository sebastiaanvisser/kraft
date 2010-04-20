function Trigger (t, f, s)
{
  this.id      = 't' + Trigger.nextId++
  this.target  = [t, f]
  this.sources = s

  Trigger.all[this.id] = this
}

Trigger.nextId = 0
Trigger.all    = {}

addToProto(Trigger,

  function destructor ()
  {
    delete this.target[0].triggers[this.id]
    for (var i = 0; i < this.sources.length; i++)
      delete this.sources[i][0].triggers[this.id]
  },

  function app (side)
  {
    var vs = [this.target[0].obj]
    for (var i = 0; i < this.sources.length; i++)
      vs.push(this.sources[i][0].obj)

    if (side)
    {
      var tmp = []
      for (var i = 0; i < this.sources.length; i++)
        tmp[i] = this.sources[i][1].apply(this, vs)
      for (var i = 0; i < this.sources.length; i++)
        this.sources[i][0].v = tmp[i]
    }
    else
      this.target[0].v = this.target[1].apply(this, vs)
  }

)

Trigger.compose =
function compose (t, f /* ... */)
{
  // Build up trigger.
  var s = []
  for (var i = 2; i < arguments.length; i += 2)
    s.push([arguments[i], arguments[i+1]])
  var trigger = new Trigger(t, f, s)

  // Install trigger.
  trigger.target[0].triggers[trigger.id] = [true, trigger]
  for (var i = 0; i < trigger.sources.length; i++)
    trigger.sources[i][0].triggers[trigger.id] = [false, trigger]

  trigger.app(false)
}

