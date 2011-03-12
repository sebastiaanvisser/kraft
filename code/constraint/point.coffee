Module "constraint.Point"

Qualified "constraint.Constraint", "C"

Static

  eq:          (a, b)    -> C.eq  a.$.x, b.$.x;        C.eq  a.$.y, b.$.y
  xy:          (a, b, c) -> C.eq  a.$.x, b.$.x;        C.eq  a.$.y, c.$.y
  yx:          (a, b, c) -> C.eq  a.$.x, c.$.x;        C.eq  a.$.y, b.$.y
  mid:         (a, b, c) -> C.mid a.$.x, b.$.x, c.$.x; C.mid a.$.y, b.$.y, c.$.y
  topLeft:     (a, b, c) -> C.min a.$.x, b.$.x, c.$.x; C.min a.$.y, b.$.y, c.$.y
  topRight:    (a, b, c) -> C.max a.$.x, b.$.x, c.$.x; C.min a.$.y, b.$.y, c.$.y
  bottomLeft:  (a, b, c) -> C.min a.$.x, b.$.x, c.$.x; C.max a.$.y, b.$.y, c.$.y
  bottomRight: (a, b, c) -> C.max a.$.x, b.$.x, c.$.x; C.max a.$.y, b.$.y, c.$.y


