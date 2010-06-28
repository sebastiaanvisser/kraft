function Class (ctor /* functions */)
{
  for (var i = 1; i < arguments.length; i++)
    ctor.prototype[arguments[i].name] = arguments[i]
}

function Static (ctor /* functions */)
{
  for (var i = 1; i < arguments.length; i++)
    ctor[arguments[i].name] = arguments[i]
}

function foreach (o, f)
{
  var res = []
  for (var p in o) res.push(f.call(o, p, o[p]))
  return res
}

function keys   (o) { return foreach(o, function(k, _) { return k; }); }
function values (o) { return foreach(o, function(_, v) { return v; }); }

function slice (arr, i, j, k)
{
  return [].slice.call(arr, i, j, k)
}

