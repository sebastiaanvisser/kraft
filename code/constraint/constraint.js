Module("constraint.Constraint")

Import("base.Trigger")

Static
(

  function eq (a, b)
  {
    Trigger.compose( a, function () { return b.v }
                   , b, function () { return a.v }
                   )
  },

  function add0 (a, b, c)
  {
    Trigger.compose( a, function () { return b.v + c.v }
                   , b, function () { return a.v - c.v }
                   , c, function () { return c.v       }
                   )
  },

  function sub0 (a, b, c)
  {
    Trigger.compose( a, function () { return b.v - c.v }
                   , b, function () { return c.v + a.v }
                   , c, function () { return c.v       }
                   )
  },

  function mid (a, b, c)
  {
    Trigger.compose( a, function () { return (b.v + c.v) / 2       }
                   , b, function () { return a.v - (c.v - b.v) / 2 }
                   , c, function () { return a.v + (c.v - b.v) / 2 }
                   )
  },

  function min (a, b, c)
  {
    Trigger.compose( a, function () { return Math.min(b.v, c.v)     }
                   , b, function () { return b.v <= c.v ? a.v : b.v }
                   , c, function () { return c.v <  b.v ? a.v : c.v }
                   )
  },

  function max (a, b, c)
  {
    Trigger.compose( a, function () { return Math.max(b.v, c.v)     }
                   , b, function () { return b.v >= c.v ? a.v : b.v }
                   , c, function () { return c.v >  b.v ? a.v : c.v }
                   )
  },

  function min0 (a, b, c)
  {
    Trigger.compose( a, function () { return Math.min(b.v, c.v)                 }
                   , b, function () { return a.v + (b.v <= c.v ? 0 : b.v - c.v) }
                   , c, function () { return a.v + (c.v <  b.v ? 0 : c.v - b.v) }
                   )
  },

  function max0 (a, b, c)
  {
    Trigger.compose( a, function () { return Math.max(b.v, c.v)                 }
                   , b, function () { return a.v - (b.v >= c.v ? 0 : c.v - b.v) }
                   , c, function () { return a.v - (c.v >  b.v ? 0 : b.v - c.v) }
                   )
  }

)
