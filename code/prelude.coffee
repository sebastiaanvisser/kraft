Module "Prelude"

Static

  keys:    (o)    -> k      for k, _ of o
  values : (o)    -> v      for _, v of o

  # todo: depracate
  foreach: (o, f) -> f k, v for k, v of o
  slice: (arr, args...) -> [].slice.call arr, args...

