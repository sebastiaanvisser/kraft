function Point (revive, ctx, x, y)
{
  if (!revive)
  {
    this.def("x", x || 0)
    this.def("y", y || 0)
  }
}

Base.register(Point)

Point.make =
function make (x, y)
{
  var p = new Base
  p.decorate(Point, null, x, y)
  return p
}

