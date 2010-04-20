function Rect (x0, y0, x1, y1)
{
  this.def("p0", Point.make(x0, y0))
  this.def("p1", Point.make(x1, y0))
  this.def("p2", Point.make(x0, y1))
  this.def("p3", Point.make(x1, y1))
  C.eq(this.p0.$.x, this.p2.$.x)
  C.eq(this.p1.$.x, this.p3.$.x)
  C.eq(this.p0.$.y, this.p1.$.y)
  C.eq(this.p2.$.y, this.p3.$.y)

  this.def("center",      Point.make())
  this.def("topLeft",     Point.make())
  this.def("topRight",    Point.make())
  this.def("bottomLeft",  Point.make())
  this.def("bottomRight", Point.make())
  this.def("midLeft",     Point.make())
  this.def("midRight",    Point.make())
  this.def("midTop",      Point.make())
  this.def("midBottom",   Point.make())
  Point.mid        (this.center,      this.p0, this.p3)
  Point.topLeft    (this.topLeft,     this.p0, this.p3)
  Point.topRight   (this.topRight,    this.p0, this.p3)
  Point.bottomLeft (this.bottomLeft,  this.p0, this.p3)
  Point.bottomRight(this.bottomRight, this.p0, this.p3)
  Point.xy         (this.midLeft,     this.p0, this.center)
  Point.xy         (this.midRight,    this.p1, this.center)
  Point.yx         (this.midTop,      this.p0, this.center)
  Point.yx         (this.midBottom,   this.p2, this.center)

  this.def("width")
  this.def("height")
  this.def("left")
  this.def("top")
  this.def("right")
  this.def("bottom")
  C.sub0(this.$.width,  this.bottomRight.$.x, this.topLeft.$.x)
  C.sub0(this.$.height, this.bottomRight.$.y, this.topLeft.$.y)
  C.min0(this.$.left,   this.p0.$.x,          this.p3.$.x     )
  C.min0(this.$.top,    this.p0.$.y,          this.p3.$.y     )
  C.max0(this.$.right,  this.p0.$.x,          this.p3.$.x     )
  C.max0(this.$.bottom, this.p0.$.y,          this.p3.$.y     )
}

Rect.make =
function make (x0, y0, x1, y1)
{
  var r = new Base
  r.decorate(Rect, x0, y0, x1, y1)
  return r
}

