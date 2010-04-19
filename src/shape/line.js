function Line () {}

Line.make =
function make (x0, y0, x1, y1, w)
{
  var r = new Base
  r.decorate(Line, x0, y0, x1, y1, w)
  return r
}

addToProto(Line,

  function constructor (x0, y0, x1, y1, w)
  {
    this.p0 = Point.make(x0, y0)
    this.p1 = Point.make(x1, y1)
    this.property("width", w)

    this.property("center",      Point.make())
    this.property("topLeft",     Point.make())
    this.property("bottomRight", Point.make())
    Point.mid         (this.center.get(),      this.p0, this.p1)
    Point.topLeft     (this.topLeft.get(),     this.p0, this.p1)
    Point.bottomRight (this.bottomRight.get(), this.p0, this.p1)

    this.property("left")
    this.property("top")
    this.property("right")
    this.property("bottom")
    C.min0(this.left,   this.p0.x, this.p1.x)
    C.min0(this.top,    this.p0.y, this.p1.y)
    C.max0(this.right,  this.p0.x, this.p1.x)
    C.max0(this.bottom, this.p0.y, this.p1.y)
  },

  function destructor ()
  {
    this.p0.destructor()
    this.p1.destructor()
    this.center.get().destructor()
    this.topLeft.get().destructor()
    this.bottomRight.get().destructor()

    // todo: cleanup
  }

)

