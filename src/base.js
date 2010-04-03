function Base ()
{
  this.properties   = {};
  this.constraintId = 0;
  this.constraints  = [];
}

Base.prototype.property =
function property (name, init, set, get)
{
  this.properties[name] =
    { v : init
    , getters : []
    , setters : []
    }

  this.__defineGetter__(name, function ()  { return this.properties[name].v })
  this.__defineSetter__(name, function (v) { this.properties[name].v = v    })
  this.wrapProperty(name, set, get)
}

Base.prototype.wrapProperty =
function wrapProperty (p, s, g)
{
  if (s)
  { var setter = this.__lookupSetter__(p)
    this.properties[p].setters.push(setter)
    this.__defineSetter__(p, function (v) { setter.call(this, s.call(this, v)) })
  }

  if (g)
  { var getter = this.__lookupGetter__(p)
    this.properties[p].getters.push(getter)
    this.__defineGetter__(p, function () { return g.call(this, getter.call(this)) })
  }
}

Base.effect =
function effect (f)
{
  return function (v) { f.call(this); return v };
}

