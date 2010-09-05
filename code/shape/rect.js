function Rect (revive, ctx, x0, y0, x1, y1)
{
  this.def("p0", Point.make(x0, y0))
  this.def("p1", Point.make(x1, y0))
  this.def("p2", Point.make(x0, y1))
  this.def("p3", Point.make(x1, y1))
  C.eq(this.p0.$.x, this.p2.$.x)
  C.eq(this.p1.$.x, this.p3.$.x)
  C.eq(this.p0.$.y, this.p1.$.y)
  C.eq(this.p2.$.y, this.p3.$.y)

  this.def1("center",      Point.make(), Point.mid,         this.p0, this.p3     )
  this.def1("topLeft",     Point.make(), Point.topLeft,     this.p0, this.p3     )
  this.def1("topRight",    Point.make(), Point.topRight,    this.p0, this.p3     )
  this.def1("bottomLeft",  Point.make(), Point.bottomLeft,  this.p0, this.p3     )
  this.def1("bottomRight", Point.make(), Point.bottomRight, this.p0, this.p3     )
  this.def1("midLeft",     Point.make(), Point.xy,          this.p0, this.center )
  this.def1("midRight",    Point.make(), Point.xy,          this.p1, this.center )
  this.def1("midTop",      Point.make(), Point.yx,          this.p0, this.center )
  this.def1("midBottom",   Point.make(), Point.yx,          this.p2, this.center )

  this.def("width",   0, C.sub0, this.bottomRight.$.x, this.topLeft.$.x )
  this.def("height",  0, C.sub0, this.bottomRight.$.y, this.topLeft.$.y )
  this.def("left",    0, C.min0, this.p0.$.x,          this.p3.$.x      )
  this.def("top",     0, C.min0, this.p0.$.y,          this.p3.$.y      )
  this.def("right",   0, C.max0, this.p0.$.x,          this.p3.$.x      )
  this.def("bottom",  0, C.max0, this.p0.$.y,          this.p3.$.y      )
}

Base.register(Rect)

Rect.make =
function make (x0, y0, x1, y1)
{
  var r = new Base
  r.decorate(Rect, null, x0, y0, x1, y1)
  return r
}

