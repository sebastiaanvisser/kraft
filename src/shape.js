Shape =
function Shape (x0, y0, x1, y1)
{
  this.baseInit()

  // Absolute view:
  this.p0 = new Point(x0, y0)
  this.p1 = new Point(x1, y0)
  this.p2 = new Point(x0, y1)
  this.p3 = new Point(x1, y1)
  C.eq(this.p0.x, this.p2.x)
  C.eq(this.p1.x, this.p3.x)
  C.eq(this.p0.y, this.p1.y)
  C.eq(this.p2.y, this.p3.y)

  // Normalized view:
  this.derivedPoint ("center",      Point.mid,         this.p0,            this.p3        )
  this.derivedPoint ("topLeft",     Point.topLeft,     this.p0,            this.p3        )
  this.derivedPoint ("topRight",    Point.topRight,    this.p0,            this.p3        )
  this.derivedPoint ("bottomLeft",  Point.bottomLeft,  this.p0,            this.p3        )
  this.derivedPoint ("bottomRight", Point.bottomRight, this.p0,            this.p3        )
  this.derivedPoint ("midLeft",     Point.xy,          this.p0,            this.center    )
  this.derivedPoint ("midRight",    Point.xy,          this.p1,            this.center    )
  this.derivedPoint ("midTop",      Point.yx,          this.p0,            this.center    )
  this.derivedPoint ("midBottom",   Point.yx,          this.p2,            this.center    )
  this.derivedProp  ("width",       C.sub0,            this.bottomRight.x, this.topLeft.x )
  this.derivedProp  ("height",      C.sub0,            this.bottomRight.y, this.topLeft.y )
  this.derivedProp  ("left",        C.min0,            this.p0.x,          this.p3.x      )
  this.derivedProp  ("top",         C.min0,            this.p0.y,          this.p3.y      )
  this.derivedProp  ("right",       C.max0,            this.p0.x,          this.p3.x      )
  this.derivedProp  ("bottom",      C.max0,            this.p0.y,          this.p3.y      )
}

Shape.prototype = new Base

Shape.prototype.destruct =
function destruct ()
{
  this.p0.cleanup()
  this.p1.cleanup()
  this.p2.cleanup()
  this.p3.cleanup()
  this.center.cleanup()
  this.topLeft.cleanup()
  this.topRight.cleanup()
  this.bottomLeft.cleanup()
  this.bottomRight.cleanup()
  this.midLeft.cleanup()
  this.midRight.cleanup()
  this.midTop.cleanup()
  this.midBottom.cleanup()

  this.unrender()
  this.cleanup()
}

