Module "constraint.Constraint"

Import "base.Value"

Static

  _: -> _

  Stage
  eq: -> constraint 1
    , ((a, b) -> b.v = a.v)
    , ((a, b) -> a.v = b.v)

  Stage
  mid: -> constraint 1
    , ((a, b, c) -> d = (c.v - b.v) / 2; b.v = a.v - d; c.v = a.v + d)
    , ((a, b, c) -> a.v = b.v + (c.v - b.v) / 2)
    , ((a, b, c) -> a.v = b.v + (c.v - b.v) / 2)

  Stage
  add0: -> constraint 1
    , ((a, b, c) -> b.v = a.v - c.v)
    , ((a, b, c) -> a.v = b.v + c.v)
    , ((a, b, c) -> a.v = b.v + c.v)

  Stage
  sub0: -> constraint 1
    , ((a, b, c) -> b.v = a.v + c.v)
    , ((a, b, c) -> a.v = b.v - c.v)
    , ((a, b, c) -> a.v = b.v - c.v)

  Stage
  min: -> constraint 1
    , ((a, b, c) -> d = a.v - Math.min b.v, c.v; b.v += d; c.v += d)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)

  Stage
  max: -> constraint 1
    , ((a, b, c) -> d = a.v - Math.max b.v, c.v; b.v -= d; c.v -= d)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)

