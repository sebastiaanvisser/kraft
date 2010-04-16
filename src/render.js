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

Point.eq =
function mid (a, b)
{
  C.eq(a.x, b.x)
  C.eq(a.y, b.y)
}

Point.mid         = function mid         (a, b, c) { C.mid(a.x, b.x, c.x); C.mid(a.y, b.y, c.y) }
Point.topLeft     = function topLeft     (a, b, c) { C.min(a.x, b.x, c.x); C.min(a.y, b.y, c.y) }
Point.topRight    = function topRight    (a, b, c) { C.max(a.x, b.x, c.x); C.min(a.y, b.y, c.y) }
Point.bottomLeft  = function bottomLeft  (a, b, c) { C.min(a.x, b.x, c.x); C.max(a.y, b.y, c.y) }
Point.bottomRight = function bottomRight (a, b, c) { C.max(a.x, b.x, c.x); C.max(a.y, b.y, c.y) }

Base.prototype.derivedPoint =
function derivedPoint (name, constraint)
{
  this[name] = new Point
  constraint.apply(null, [this[name]].concat([].slice.call(arguments, 2)))
}



Render.Rect =
function Rect (x0, y0, x1, y1)
{
  this.baseInit()
  this.onchange(this.render)
  this.elem = this.setupElem()

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
  this.derivedPoint("center",      Point.mid,         this.p0, this.p3)
  this.derivedPoint("topLeft",     Point.topLeft,     this.p0, this.p3)
  this.derivedPoint("topRight",    Point.topRight,    this.p0, this.p3)
  this.derivedPoint("bottomLeft",  Point.bottomLeft,  this.p0, this.p3)
  this.derivedPoint("bottomRight", Point.bottomRight, this.p0, this.p3)

  this.derivedProp("width",  C.sub0, this.bottomRight.x, this.topLeft.x)
  this.derivedProp("height", C.sub0, this.bottomRight.y, this.topLeft.y)
  this.derivedProp("left",   C.min0, this.p0.x, this.p3.x)
  this.derivedProp("top",    C.min0, this.p0.y, this.p3.y)
  this.derivedProp("right",  C.max0, this.p0.x, this.p3.x)
  this.derivedProp("bottom", C.max0, this.p0.y, this.p3.y)

  this.initialized()
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
  // this.handles.midLeft     = mkHandle()
  // this.handles.midRight    = mkHandle()
  // this.handles.midTop      = mkHandle()
  // this.handles.midBottom   = mkHandle()

  Point.eq(this.handles.topLeft.center,     this.p0)
  Point.eq(this.handles.topRight.center,    this.p1)
  Point.eq(this.handles.bottomLeft.center,  this.p2)
  Point.eq(this.handles.bottomRight.center, this.p3)
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
  this.elem.style.left   = this.left.get()   + "px"
  this.elem.style.top    = this.top.get()    + "px"
  this.elem.style.width  = this.width.get()  + "px"
  this.elem.style.height = this.height.get() + "px"
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

