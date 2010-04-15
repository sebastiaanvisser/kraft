var C = {}

C.getter = function getter (p) { return function () { return p.get() } }

C.eq = function eq (a, b) { compose(a, C.getter(b), b, C.getter(a)) }

C.sub0 =
function sub0 (a, b, c)
{
  compose( a, function (s) { return b.get() - c.get() }
         , b, function (s) { return c.get() + a.get() }
         , c, function (s) { return c.get()           }
         )              
}

C.mid =
function mid (a, b, c)
{
  compose( a, function (s) { return (b.get() + c.get()) / 2           }
         , b, function (s) { return a.get() - (c.get() - b.get()) / 2 }
         , c, function (s) { return a.get() + (c.get() - b.get()) / 2 }
         )              
}

C.min0 =
function min0 (a, b, c)
{
  compose( a, function (s) { return b.get()                     }
         , b, function (s) { return a.get()                     }
         , c, function (s) { return a.get() + c.get() - b.get() }
         )
}

C.max0 =
function max0 (a, b, c)
{
  compose( a, function (s) { return c.get()                     }
         , b, function (s) { return a.get() - c.get() + b.get() }
         , c, function (s) { return a.get()                     }
         )
}

