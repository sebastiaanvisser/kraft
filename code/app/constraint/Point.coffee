Module "constraint.Point"

Import "base.Obj"
Qualified "shape.Point", As "Pt"
Qualified "constraint.Constraint", As "C"

Static

  eq:          (a, b) ->            C.eq  a.$.x, b.$.x;        C.eq  a.$.y, b.$.y
  topLeft:     (a, b) -> p = mk Pt; C.min p.$.x, a.$.x, b.$.x; C.min p.$.y, a.$.y, b.$.y; p
  topRight:    (a, b) -> p = mk Pt; C.max p.$.x, a.$.x, b.$.x; C.min p.$.y, a.$.y, b.$.y; p
  bottomLeft:  (a, b) -> p = mk Pt; C.min p.$.x, a.$.x, b.$.x; C.max p.$.y, a.$.y, b.$.y; p
  bottomRight: (a, b) -> p = mk Pt; C.max p.$.x, a.$.x, b.$.x; C.max p.$.y, a.$.y, b.$.y; p
  xy:          (a, b) -> p = mk Pt; C.eq  p.$.x, a.$.x;        C.eq  p.$.y, b.$.y; p
  yx:          (a, b) -> p = mk Pt; C.eq  p.$.x, b.$.x;        C.eq  p.$.y, a.$.y; p
  mid:         (a, b) -> p = mk Pt; C.mid p.$.x, a.$.x, b.$.x; C.mid p.$.y, a.$.y, b.$.y; p

