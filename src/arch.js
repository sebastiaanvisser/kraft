
function property (self, prop, init, fun)
{
  self.__defineGetter__(prop, function ()  { return this["_" + prop]                 })
  self.__defineSetter__(prop, function (v) { this["_" + prop] = v; fun.call(self, v) })
  self[prop] = init;
}

