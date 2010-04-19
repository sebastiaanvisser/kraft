function addToProto (ctor /* functions */)
{
  for (var i = 1; i < arguments.length; i++)
    ctor.prototype[arguments[i].name] = arguments[i];
}

