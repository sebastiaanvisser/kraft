Point.eq          = function mid         (a, b)    { C.eq(a.$.x, b.$.x);         C.eq(a.$.y, b.$.y)         }
Point.xy          = function xy          (a, b, c) { C.eq(a.$.x, b.$.x);         C.eq(a.$.y, c.$.y)         }
Point.yx          = function yx          (a, b, c) { C.eq(a.$.x, c.$.x);         C.eq(a.$.y, b.$.y)         }
Point.mid         = function mid         (a, b, c) { C.mid(a.$.x, b.$.x, c.$.x); C.mid(a.$.y, b.$.y, c.$.y) }
Point.topLeft     = function topLeft     (a, b, c) { C.min(a.$.x, b.$.x, c.$.x); C.min(a.$.y, b.$.y, c.$.y) }
Point.topRight    = function topRight    (a, b, c) { C.max(a.$.x, b.$.x, c.$.x); C.min(a.$.y, b.$.y, c.$.y) }
Point.bottomLeft  = function bottomLeft  (a, b, c) { C.min(a.$.x, b.$.x, c.$.x); C.max(a.$.y, b.$.y, c.$.y) }
Point.bottomRight = function bottomRight (a, b, c) { C.max(a.$.x, b.$.x, c.$.x); C.max(a.$.y, b.$.y, c.$.y) }
