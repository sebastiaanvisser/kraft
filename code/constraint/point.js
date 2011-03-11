Module("constraint.Point")

Qualified("constraint.Constraint", "C")

Static
(

  function eq          (a, b)    { C.eq(a.$.x, b.$.x);         C.eq(a.$.y, b.$.y)         },
  function xy          (a, b, c) { C.eq(a.$.x, b.$.x);         C.eq(a.$.y, c.$.y)         },
  function yx          (a, b, c) { C.eq(a.$.x, c.$.x);         C.eq(a.$.y, b.$.y)         },
  function mid         (a, b, c) { C.mid(a.$.x, b.$.x, c.$.x); C.mid(a.$.y, b.$.y, c.$.y) },
  function topLeft     (a, b, c) { C.min(a.$.x, b.$.x, c.$.x); C.min(a.$.y, b.$.y, c.$.y) },
  function topRight    (a, b, c) { C.max(a.$.x, b.$.x, c.$.x); C.min(a.$.y, b.$.y, c.$.y) },
  function bottomLeft  (a, b, c) { C.min(a.$.x, b.$.x, c.$.x); C.max(a.$.y, b.$.y, c.$.y) },
  function bottomRight (a, b, c) { C.max(a.$.x, b.$.x, c.$.x); C.max(a.$.y, b.$.y, c.$.y) }

)

