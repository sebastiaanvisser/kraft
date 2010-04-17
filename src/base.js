Debug = false

function Property (o, n, v)
{
  this.obj      = o
  this.name     = n
  this.value    = v
  this.busy     = false
  this.triggers = []
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

if (Debug) console.log(Property.depth, "setting", this.name, "to", v)

  this.value = v

  for (var i = 0; i < this.triggers.length; i++)
    this.triggers[i][1].app(this.triggers[i][0])

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
  trigger.target[0].triggers.push([true, trigger]);
  for (var i = 0; i < trigger.sources.length; i++)
    trigger.sources[i][0].triggers.push([false, trigger]);

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
  this.$.properties[name] = { v : init }
}

Base.prototype.derivedProp =
function derivedProp (name, constraint)
{
  this.property(name)
  constraint.apply(null, [this[name]].concat([].slice.call(arguments, 2)))
}

