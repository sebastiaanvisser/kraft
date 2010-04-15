var Render = {}

// ----------------------------------------------------------------------------

/*

Render.Line =
function Line (left, top, right, bottom, width)
{
  this.baseInit()

  this.elem = this.setupElem()

  this.property("left",   left   || 0, Base.effect(this.render))
  this.property("top",    top    || 0, Base.effect(this.render))
  this.property("right",  right  || 0, Base.effect(this.render))
  this.property("bottom", bottom || 0, Base.effect(this.render))
  this.property("width",  width  || 5, Base.effect(this.render))

  this.createHandles()
}

Render.Line.prototype = new Base

Render.Line.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "line")
  elem.style.position = "absolute"
  return elem
}

Render.Line.prototype.createHandles =
function createHandles ()
{
  this.handleA = new Render.Ellipse(10, 10, 30, 30)
  // this.constraint("left", this.handleA, "left", function (a) { return a})
}

Render.Line.prototype.render =
function render ()
{
  var len = Math.sqrt(Math.pow(this.right - this.left, 2) + Math.pow(this.bottom - this.top, 2))
  var rot = Math.atan((this.bottom - this.top) / (this.right - this.left)) * 180 / Math.PI

  this.elem.style.left   = ((this.left + this.right - len)        / 2) + "px"
  this.elem.style.top    = ((this.top + this.bottom - this.width) / 2) + "px"
  this.elem.style.width  = len                                         + "px"
  this.elem.style.height = this.width                                  + "px"

  this.elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"
}

*/

// ----------------------------------------------------------------------------

Point =
function Point (x, y)
{
  this.baseInit()

  this.property("x", x || 0)
  this.property("y", y || 0)
}

Point.prototype = new Base

Point.mid = 
function mid (c, a, b)
{
  C.mid(c.x, a.x, b.x)
  C.mid(c.y, a.y, b.y)
}

Render.Rect =
function Rect (x0, y0, x1, y1)
{
  this.baseInit()
  this.onchange(this.render)

  this.elem = this.setupElem()

  this.p0 = new Point(x0, y0)
  this.p1 = new Point(x1, y1)

  this.center = new Point()

  this.property("width")
  this.property("height")
  this.property("left")
  this.property("right")
  this.property("top")
  this.property("bottom")

  C.sub0 (this.width,   this.p1.x, this.p0.x)
  C.sub0 (this.height,  this.p1.y, this.p0.y)
  C.min0 (this.left,    this.p0.x, this.p1.x)
  C.min0 (this.top,     this.p0.y, this.p1.y)
  C.max0 (this.right,   this.p0.x, this.p1.x)
  C.max0 (this.bottom,  this.p0.y, this.p1.y)

  Point.mid (this.center, this.p0, this.p1)

}

Render.Rect.prototype = new Base

Render.Rect.prototype.mkHandles =
function mkHandles ()
{
  function mkHandle ()
  {
    var h = new Render.Rect(0, 0, 20, 20)
    h.elem.className += " handle"
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

  C.eq(this.handles.topLeft.center.x,     this.p0.x)
  C.eq(this.handles.topLeft.center.y,     this.p0.y)

  C.eq(this.handles.topRight.center.x,    this.p1.x)
  C.eq(this.handles.topRight.center.y,    this.p0.y)

  C.eq(this.handles.bottomLeft.center.x,  this.p0.x)
  C.eq(this.handles.bottomLeft.center.y,  this.p1.y)

  C.eq(this.handles.bottomRight.center.x, this.p1.x)
  C.eq(this.handles.bottomRight.center.y, this.p1.y)

  C.eq(this.handles.midLeft.center.x,     this.p0.x)
  C.eq(this.handles.midLeft.center.y,     this.center.y)

  C.eq(this.handles.midRight.center.x,    this.p1.x)
  C.eq(this.handles.midRight.center.y,    this.center.y)

  C.eq(this.handles.midTop.center.x,      this.center.x)
  C.eq(this.handles.midTop.center.y,      this.p0.y)

  C.eq(this.handles.midBottom.center.x,   this.center.x)
  C.eq(this.handles.midBottom.center.y,   this.p1.y)
}

Render.Rect.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  return elem
}

Render.Rect.prototype.render =
function render ()
{
if (Debug) console.log("render")
  this.elem.style.left   = (this.p0.x.get()                  ) + "px"
  this.elem.style.top    = (this.p0.y.get()                  ) + "px"
  this.elem.style.width  = (this.p1.x.get() - this.p0.x.get()) + "px"
  this.elem.style.height = (this.p1.y.get() - this.p0.y.get()) + "px"
}

// ----------------------------------------------------------------------------

/*

Render.Ellipse =
function Ellipse (left, top, right, bottom)
{
  this.baseInit()

  this.elem = this.setupElem()

  this.property("left",   left   || 0, Base.effect(this.render))
  this.property("top",    top    || 0, Base.effect(this.render))
  this.property("right",  right  || 0, Base.effect(this.render))
  this.property("bottom", bottom || 0, Base.effect(this.render))
}

Render.Ellipse.prototype = new Base

Render.Ellipse.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  return elem
}

Render.Ellipse.prototype.render =
function render ()
{
  var w = this.right  - this.left;
  var h = this.bottom - this.top;

  this.elem.style.left   = this.left + "px"
  this.elem.style.top    = this.top  + "px"
  this.elem.style.width  = w         + "px"
  this.elem.style.height = h         + "px"

  this.elem.style.borderTopLeftRadius     =
  this.elem.style.borderTopRightRadius    =
  this.elem.style.borderBottomLeftRadius  =
  this.elem.style.borderBottomRightRadius = w/2 + "px " + h/2 + "px "
}

*/

