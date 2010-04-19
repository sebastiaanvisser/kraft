function Shape () {}

Shape.make =
function make (x0, y0, x1, y1)
{
  var r = new Base
  r.decorate(Shape, x0, y0, x1, y1)
  return r
}

addToProto(Shape,

  function constructor (x0, y0, x1, y1)
  {
    this.p0 = Point.make(x0, y0)
    this.p1 = Point.make(x1, y0)
    this.p2 = Point.make(x0, y1)
    this.p3 = Point.make(x1, y1)
    C.eq(this.p0.x, this.p2.x)
    C.eq(this.p1.x, this.p3.x)
    C.eq(this.p0.y, this.p1.y)
    C.eq(this.p2.y, this.p3.y)

    this.property("center",      Point.make())
    this.property("topLeft",     Point.make())
    this.property("topRight",    Point.make())
    this.property("bottomLeft",  Point.make())
    this.property("bottomRight", Point.make())
    this.property("midLeft",     Point.make())
    this.property("midRight",    Point.make())
    this.property("midTop",      Point.make())
    this.property("midBottom",   Point.make())
    Point.mid         (this.center.get(),      this.p0, this.p3)
    Point.topLeft     (this.topLeft.get(),     this.p0, this.p3)
    Point.topRight    (this.topRight.get(),    this.p0, this.p3)
    Point.bottomLeft  (this.bottomLeft.get(),  this.p0, this.p3)
    Point.bottomRight (this.bottomRight.get(), this.p0, this.p3)
    Point.xy          (this.midLeft.get(),     this.p0, this.center.get())
    Point.xy          (this.midRight.get(),    this.p1, this.center.get())
    Point.yx          (this.midTop.get(),      this.p0, this.center.get())
    Point.yx          (this.midBottom.get(),   this.p2, this.center.get())

    this.property("width")
    this.property("height")
    this.property("left")
    this.property("top")
    this.property("right")
    this.property("bottom")
    C.sub0(this.width,  this.bottomRight.get().x, this.topLeft.get().x )
    C.sub0(this.height, this.bottomRight.get().y, this.topLeft.get().y )
    C.min0(this.left,   this.p0.x,                this.p3.x            )
    C.min0(this.top,    this.p0.y,                this.p3.y            )
    C.max0(this.right,  this.p0.x,                this.p3.x            )
    C.max0(this.bottom, this.p0.y,                this.p3.y            )
  },

  function destructor ()
  {
    this.p0.destructor()
    this.p1.destructor()
    this.p2.destructor()
    this.p3.destructor()
    this.center.get().destructor()
    this.topLeft.get().destructor()
    this.topRight.get().destructor()
    this.bottomLeft.get().destructor()
    this.bottomRight.get().destructor()
    this.midLeft.get().destructor()
    this.midRight.get().destructor()
    this.midTop.get().destructor()
    this.midBottom.get().destructor()
  }

)

function DraggableShape () {}

addToProto(DraggableShape,

  function constructor ()
  {
    this.dragger = new Draggable(this.canvas, this, this.elem, false, false, 10, 10)
  }

)

