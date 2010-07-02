function Line (x0, y0, x1, y1, w)
{
  this.def("p0", Point.make(x0, y0))
  this.def("p1", Point.make(x1, y1))
  this.def("width", w)

  this.def1("center",      Point.make(), Point.mid,         this.p0, this.p1)
  this.def1("topLeft",     Point.make(), Point.topLeft,     this.p0, this.p1)
  this.def1("bottomRight", Point.make(), Point.bottomRight, this.p0, this.p1)
  
  this.def("left",   0, C.min0, this.p0.$.x, this.p1.$.x)
  this.def("top",    0, C.min0, this.p0.$.y, this.p1.$.y)
  this.def("right",  0, C.max0, this.p0.$.x, this.p1.$.x)
  this.def("bottom", 0, C.max0, this.p0.$.y, this.p1.$.y)
}

Base.register(Line)

Line.make =
function make (x0, y0, x1, y1, w)
{
  var r = new Base
  r.decorate(Line, x0, y0, x1, y1, w)
  return r
}

