function property (o, p, i, s, g)
{
  o.__defineGetter__(p, function ()  { return this["_" + p] })
  o.__defineSetter__(p, function (v) { this["_" + p] = v    })
  wrapProperty(o, p, s, g)
  o[p] = i;
}

function wrapProperty (o, p, s, g)
{
  if (s) { var setter = o.__lookupSetter__(p);
           o.__defineSetter__(p, function (v) { setter.call(o, s.call(o, v)) })
         }
  if (g) { var getter = o.__lookupGetter__(p);
           o.__defineGetter__(p, function ()  { return g.call(o, getter.call(o)) })
         }
}

function effect (f)
{
  return function (v) { f.call(this); return v };
}

