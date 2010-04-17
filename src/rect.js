Rect =
function Rect (x0, y0, x1, y1)
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

Rect.prototype = new Base

// --------------------------

Rect.prototype.renderable =
function renderable (canvas)
{
  this.canvas = canvas
  this.elem   = this.setupElem()
  this.render()

  this.onchange(this.render)
}

Rect.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  this.canvas.appendChild(elem)
  return elem
}

Rect.prototype.render =
function render ()
{
  this.elem.style.left   = this.left.get()   + "px"
  this.elem.style.top    = this.top.get()    + "px"
  this.elem.style.width  = this.width.get()  + "px"
  this.elem.style.height = this.height.get() + "px"
}

Rect.prototype.unrender =
function unrender ()
{
  this.canvas.removeChild(this.elem)
}

// --------------------------

Rect.prototype.mkHandles =
function mkHandles ()
{
  var self = this
  function mkHandle ()
  {
    var h = new Rect(0, 0, 10, 10)
    h.renderable(self.canvas)
    h.elem.className += " handle"
    new Draggable(h.canvas, h, h.elem, false, false, 10, 10)
    return h
  }

  this.handles = {}
  this.handles.topLeft     = mkHandle()
  this.handles.topRight    = mkHandle()
  this.handles.bottomLeft  = mkHandle()
  this.handles.bottomRight = mkHandle()
  this.handles.midLeft     = mkHandle()
  this.handles.midRight    = mkHandle()
  this.handles.midTop      = mkHandle()
  this.handles.midBottom   = mkHandle()

  Point.eq(this.handles.topLeft.center,     this.p0)
  Point.eq(this.handles.topRight.center,    this.p1)
  Point.eq(this.handles.bottomLeft.center,  this.p2)
  Point.eq(this.handles.bottomRight.center, this.p3)
  Point.eq(this.handles.midLeft.center,     this.midLeft)
  Point.eq(this.handles.midRight.center,    this.midRight)
  Point.eq(this.handles.midTop.center,      this.midTop)
  Point.eq(this.handles.midBottom.center,   this.midBottom)
}

Rect.prototype.removeHandles =
function removeHandles ()
{
  for (var p in this.handles)
    this.handles[p].unrender()
}

