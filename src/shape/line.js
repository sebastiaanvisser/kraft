function Line (x0, y0, x1, y1, w)
{
  this.def("p0", Point.make(x0, y0))
  this.def("p1", Point.make(x1, y1))
  this.def("width", w)

  this.def("center",      Point.make())
  this.def("topLeft",     Point.make())
  this.def("bottomRight", Point.make())
  Point.mid        (this.center,      this.p0, this.p1)
  Point.topLeft    (this.topLeft,     this.p0, this.p1)
  Point.bottomRight(this.bottomRight, this.p0, this.p1)

  this.def("left")
  this.def("top")
  this.def("right")
  this.def("bottom")
  C.min0(this.$.left,   this.p0.$.x, this.p1.$.x)
  C.min0(this.$.top,    this.p0.$.y, this.p1.$.y)
  C.max0(this.$.right,  this.p0.$.x, this.p1.$.x)
  C.max0(this.$.bottom, this.p0.$.y, this.p1.$.y)
}

Line.make =
function make (x0, y0, x1, y1, w)
{
  var r = new Base
  r.decorate(Line, x0, y0, x1, y1, w)
  return r
}
