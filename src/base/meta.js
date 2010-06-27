function Class (ctor /* functions */)
{
  for (var i = 1; i < arguments.length; i++)
    ctor.prototype[arguments[i].name] = arguments[i];
}

function Static (ctor /* functions */)
{
  for (var i = 1; i < arguments.length; i++)
    ctor[arguments[i].name] = arguments[i];
}

function foreach (o, f)
{
  for (var p in o) f.call(o, o[p])
}

function slice (arr, i, j, k)
{
  return [].slice.call(arr, i, j, k)
}

