Module "Prelude"

Static

  zip: (a, b, c) ->
    len = Math.max a.length, b.length
    c a[i], b[i] for i in [0..len - 1]

  keys:    (o)    -> k      for k, _ of o
  values : (o)    -> v      for _, v of o

  # todo: depracate
  foreach: (o, f) -> f k, v for k, v of o
  slice: (arr, args...) -> [].slice.call arr, args...

