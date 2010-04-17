function Property (o, n, v)
{
  this.obj      = o
  this.name     = n
  this.value    = v
  this.busy     = false
  this.triggers = {}
}

Property.prototype.cleanup =
function cleanup ()
{
  for (var t in this.triggers)
    this.triggers[t][1].cleanup()
}

Property.depth = 0

Property.prototype.get =
function get () { return this.value }

Property.prototype.set =
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

var NextTriggerId = 0
var Triggers      = {}

function Trigger (t, f, s)
{
  this.id      = NextTriggerId++
  this.target  = [t, f]
  this.sources = s

  Triggers[this.id] = this
}

Trigger.prototype.cleanup =
function cleanup ()
{
  console.log("cleanup: ", this.id)
  delete this.target[0].triggers[this.id]
  for (var i = 0; i < this.sources.length; i++)
    delete this.sources[i][0].triggers[this.id]
}

Trigger.prototype.app =
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
      this.sources[i][0].set(tmp[i])
  }
  else
    this.target[0].set(this.target[1].apply(this, vs))
}

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

function Base () { }

Base.prototype.baseInit =
function baseInit ()
{
  this.$ = { id          : Base.nextId++
           , properties  : {}
           , onchange    : []
           }
  Base.objects[this.$.id] = this
}

Base.prototype.countTriggers =
function countTriggers ()
{
  var c = 0
  for (var p in this.$.properties)
    for (var t in this.$.properties[p].triggers)
      c++
  return c
}

Base.prototype.cleanup =
function cleanup ()
{
  for (var p in this.$.properties)
    this.$.properties[p].cleanup()
}

Base.prototype.onchange =
function onchange (f)
{
  this.$.onchange.push(f)
}

Base.prototype.appEffects =
function appEffects (v)
{
  for (var i = 0; i < this.$.onchange.length; i++)
    this.$.onchange[i].call(this, v)
}

Base.nextId  = 0
Base.objects = {}

Base.prototype.property =
function property (name, init)
{
  this[name] = new Property(this, name, init)
  this.$.properties[name] = this[name]
}

Base.prototype.derivedProp =
function derivedProp (name, constraint)
{
  this.property(name)
  constraint.apply(null, [this[name]].concat([].slice.call(arguments, 2)))
}

