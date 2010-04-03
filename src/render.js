var Render = {}

// ----------------------------------------------------------------------------

Render.Line =
function Line (left, top, right, bottom, width)
{
  this.elem   = this.setupElem()
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
  // this.handleA = new Render.Ellipse(10, 10, 30, 30)
  // mkConstraint(this, "left", this.handleA, "left", C.eq, C.eq)
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

// ----------------------------------------------------------------------------

Render.Rect =
function Rect (left, top, right, bottom)
{
  this.elem   = this.setupElem()

  this.property("left",   left   || 0, Base.effect(this.render))
  this.property("top",    top    || 0, Base.effect(this.render))
  this.property("right",  right  || 0, Base.effect(this.render))
  this.property("bottom", bottom || 0, Base.effect(this.render))
}

Render.Rect.prototype = new Base

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
  this.elem.style.left   = this.left                + "px"
  this.elem.style.top    = this.top                 + "px"
  this.elem.style.width  = (this.right - this.left) + "px"
  this.elem.style.height = (this.bottom - this.top) + "px"
}

// ----------------------------------------------------------------------------

Render.Ellipse =
function Ellipse (left, top, right, bottom)
{
  this.elem   = this.setupElem()

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

