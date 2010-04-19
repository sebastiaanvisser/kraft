var C = {}

C.getter = function getter (p) { return function () { return p.get() } }

C.eq = function eq (a, b) { compose(a, C.getter(b), b, C.getter(a)) }

C.sub0 =
function sub0 (a, b, c)
{
  compose( a, function () { return b.get() - c.get() }
         , b, function () { return c.get() + a.get() }
         , c, function () { return c.get()           }
         )              
}

C.mid =
function mid (a, b, c)
{
  compose( a, function () { return (b.get() + c.get()) / 2           }
         , b, function () { return a.get() - (c.get() - b.get()) / 2 }
         , c, function () { return a.get() + (c.get() - b.get()) / 2 }
         )              
}

C.min =
function min (a, b, c)
{
  compose( a, function () { return Math.min(b.get(), c.get())             }
         , b, function () { return b.get() <= c.get() ? a.get() : b.get() }
         , c, function () { return c.get() <  b.get() ? a.get() : c.get() }
         )
}

C.max =
function max (a, b, c)
{
  compose( a, function () { return Math.max(b.get(), c.get())             }
         , b, function () { return b.get() >= c.get() ? a.get() : b.get() }
         , c, function () { return c.get() >  b.get() ? a.get() : c.get() }
         )
}

C.min0 =
function min0 (a, b, c)
{
  compose( a, function () { return Math.min(b.get(), c.get())                             }
         , b, function () { return a.get() + (b.get() <= c.get() ? 0 : b.get() - c.get()) }
         , c, function () { return a.get() + (c.get() <  b.get() ? 0 : c.get() - b.get()) }
         )
}

C.max0 =
function max0 (a, b, c)
{
  compose( a, function () { return Math.max(b.get(), c.get())             }
         , b, function () { return a.get() - (b.get() >= c.get() ? 0 : c.get() - b.get()) }
         , c, function () { return a.get() - (c.get() >  b.get() ? 0 : b.get() - c.get()) }
         )
}

