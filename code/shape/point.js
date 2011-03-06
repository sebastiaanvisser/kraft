function Point (revive, ctx, x, y)
{
  if (!revive)
  {
    this.def("x", x || 0)
    this.def("y", y || 0)
  }
}

Obj.register(Point)

Point.make =
function make (x, y)
{
  var p = new Obj
  p.decorate(Point, null, x, y)
  return p
}

