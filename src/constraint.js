var C = {}

C.eq  = Base.mkConstraint("eq",  1, function eq  (a)    { return a     })
C.add = Base.mkConstraint("add", 2, function add (a, b) { return a + b })
C.sub = Base.mkConstraint("sub", 2, function sub (a, b) { return a - b })
C.mul = Base.mkConstraint("mul", 2, function mul (a, b) { return a * b })
C.div = Base.mkConstraint("div", 2, function div (a, b) { return a / b })

var C2 = {}

C2.sum =
function sum (o0, p1, o1, p0, o2, p2)
{
  o1.constraint(p1, C.add(o0, p0, o2, p2))
  o2.constraint(p2, C.sub(o1, p1, o0, p0))
  o0.constraint(p0, C.sub(o1, p1, o2, p2))
}

