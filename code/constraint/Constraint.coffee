Module "constraint.Constraint"

Import "base.Value"

Static

  _: -> _

  Stage
  eq: -> constraint "eq", 1
    , ((a, b) -> b.v = a.v)
    , ((a, b) -> a.v = b.v)

  Stage
  mid: -> constraint "mid", 1
    , ((a, b, c) -> d = (c.v - b.v) / 2; b.v = a.v - d; c.v = a.v + d)
    , ((a, b, c) -> a.v = b.v + (c.v - b.v) / 2)
    , ((a, b, c) -> a.v = b.v + (c.v - b.v) / 2)

  Stage
  add0: -> constraint "add", 1
    , ((a, b, c) -> b.v = a.v - c.v)
    , ((a, b, c) -> a.v = b.v + c.v)
    , ((a, b, c) -> a.v = b.v + c.v)

  Stage
  sub0: -> constraint "sub0", 1
    , ((a, b, c) -> b.v = a.v + c.v)
    , ((a, b, c) -> a.v = b.v - c.v)
    , ((a, b, c) -> a.v = b.v - c.v)

  Stage
  min: -> constraint "min", 1
    , ((a, b, c) -> d = a.v - Math.min b.v, c.v; b.v += d; c.v += d)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)

  Stage
  max: -> constraint "max", 1
    , ((a, b, c) -> d = a.v - Math.max b.v, c.v; b.v += d; c.v += d)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)

  Stage
  minI: -> constraint "minI", 1
    , ((a, b, c) -> b.v = Math.max a.v, b.v; c.v = Math.max a.v, c.v)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)
    , ((a, b, c) -> a.v = Math.min b.v, c.v)

  Stage
  maxI: -> constraint "minI", 1
    , ((a, b, c) -> b.v = Math.min a.v, b.v; c.v = Math.min a.v, c.v)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)
    , ((a, b, c) -> a.v = Math.max b.v, c.v)

