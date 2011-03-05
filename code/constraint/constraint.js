var C = {}

C.eq =
function eq (a, b)
{
  Trigger.compose( a, function () { return b.v }
                 , b, function () { return a.v }
                 )
}

C.add0 =
function add0 (a, b, c)
{
  Trigger.compose( a, function () { return b.v + c.v }
                 , b, function () { return a.v - c.v }
                 , c, function () { return c.v       }
                 )
}

C.sub0 =
function sub0 (a, b, c)
{
  Trigger.compose( a, function () { return b.v - c.v }
                 , b, function () { return c.v + a.v }
                 , c, function () { return c.v       }
                 )
}

C.mid =
function mid (a, b, c)
{
  Trigger.compose( a, function () { return (b.v + c.v) / 2       }
                 , b, function () { return a.v - (c.v - b.v) / 2 }
                 , c, function () { return a.v + (c.v - b.v) / 2 }
                 )
}

C.min =
function min (a, b, c)
{
  Trigger.compose( a, function () { return Math.min(b.v, c.v)     }
                 , b, function () { return b.v <= c.v ? a.v : b.v }
                 , c, function () { return c.v <  b.v ? a.v : c.v }
                 )
}

C.max =
function max (a, b, c)
{
  Trigger.compose( a, function () { return Math.max(b.v, c.v)     }
                 , b, function () { return b.v >= c.v ? a.v : b.v }
                 , c, function () { return c.v >  b.v ? a.v : c.v }
                 )
}

C.min0 =
function min0 (a, b, c)
{
  Trigger.compose( a, function () { return Math.min(b.v, c.v)                 }
                 , b, function () { return a.v + (b.v <= c.v ? 0 : b.v - c.v) }
                 , c, function () { return a.v + (c.v <  b.v ? 0 : c.v - b.v) }
                 )
}

C.max0 =
function max0 (a, b, c)
{
  Trigger.compose( a, function () { return Math.max(b.v, c.v)                 }
                 , b, function () { return a.v - (b.v >= c.v ? 0 : c.v - b.v) }
                 , c, function () { return a.v - (c.v >  b.v ? 0 : b.v - c.v) }
                 )
}

