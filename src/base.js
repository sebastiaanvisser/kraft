function Base () { }

Base.nextId  = 0
Base.objects = {}


Base.prototype.baseInit =
function baseInit ()
{
  this.$ = { id               : Base.nextId++
           , properties       : {}
           , nextConstraintId : 0
           , constraints      : {}
           , triggers         : {}
           }

  Base.objects[this.$.id] = this
}

Base.prototype.property =
function property (name, init, listen)
{
  this.$.properties[name] = { v : init }

  function get () { return this.$.properties[name].v }

  function set (v)
  {
    if (this.$.properties[name].v == v) return
    this.$.properties[name].v = v
    this.collect(name, v)
    if (listen) listen.call(this, v)
  }

  this.__defineGetter__(name, get)
  this.__defineSetter__(name, set)
}

Base.prototype.collect =
function collect (name, v)
{
  // Return when no trigger available for this property.
  var t = this.$.triggers[name]
  if (!t) return

  // When this property is marked as `busy' we return to prevent any cycles.
  // When we are allowed to run we set the `busy' mark to prevent apply
  // triggers for this same property again.
  if (this.$.properties[name].busy)
  {
    console.info("cycle detected: ", this, name, v)
    return
  }
  this.$.properties[name].busy = true

  // Apply all installed triggers.
  var cs = []
  for (var i = 0; i < t.length; i++)
  {
    var def = t[i].def,
        src = t[i].sources,
        trg = t[i].target,
        as  = []

    // Collect the function arguments.
    for (var a = 0; a < def.arity; a++)
      as.push(src[a].obj[src[a].prop])

    // Apply the constraint function.
    var w = def.fun.apply(this, as)
    if (trg.obj[trg.prop] != w)
      trg.obj[trg.prop] = w
  }

  // Free this property.
  this.$.properties[name].busy = false
}

function compose (o, p, f /* ... */)
{
  var as = arguments
  o.__defineGetter__(p,
    function ()
    {
      var vs = [null]
      for (var i = 3; i < as.length; i += 3)
        vs.push(as[i][as[i+1]])
      return f.apply(o, vs)
    })
  o.__defineSetter__(p,
    function (v)
    {
      var vs = [v]
      for (var i = 3; i < as.length; i += 3)
        vs.push(as[i][as[i+1]])
      for (var i = 3; i < as.length; i += 3)
        as[i][as[i+1]] = as[i+2].apply(as[i], vs)
    })
}

Base.prototype.dumpTriggers =
function dumpTriggers ()
{
  var ts = this.$.triggers
  for (var name in ts)
  {
    var t = ts[name]
    for (var i = 0; i < t.length; i++)
    {
      var def = t[i].def,
          trg = t[i].target
      console.log( this.$.id + ":" + name, "~>"
                 , trg.obj.$.id + ":" + trg.prop
                 , "(via " + def.fun.name + ")"
                 )
    }
  }
}


Base.effect =
function effect (f)
{
  return function (v) { f.call(this); return v }
}

Base.mkConstraint = 
function mkConstraint (name, arity, fun)
{
  var def = { name : name, arity : arity, fun : fun }
  return function ()
         {
           var sources = []
           for (var i = 0; i < arguments.length; i += 2)
             sources.push({ obj  : arguments[i    ]
                          , prop : arguments[i + 1]
                          })
           return { def     : def
                  , sources : sources
                  }
         }
}

Base.prototype.constraint =
function constraint (p, c)
{
  var id = this.$.nextConstraintId++
  c.id     = id
  c.target = { obj : this, prop : p }
  this.$.constraints[id] = c;

  for (var i = 0; i < c.sources.length; i++)
  {
    var s = c.sources[i]
    s.obj.$.triggers[s.prop] = s.obj.$.triggers[s.prop] || []
    s.obj.$.triggers[s.prop].push(c)
  }

}

