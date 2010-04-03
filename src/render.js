var Render = {}

Render.Line =
function Line (left, top, right, bottom, width)
{
  this.elem   = this.setupElem()
  this.left   = left   || 0
  this.top    = top    || 0
  this.right  = right  || 0
  this.bottom = bottom || 0
  this.width  = width  || 10
}

Render.Line.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "line")
  elem.style.position = "absolute"
  return elem
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

Render.Rect =
function Rect (left, top, right, bottom)
{
  this.elem   = this.setupElem()
  this.left   = left   || 0
  this.top    = top    || 0
  this.right  = right  || 0
  this.bottom = bottom || 0
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
  this.elem.style.left   = this.left                + "px"
  this.elem.style.top    = this.top                 + "px"
  this.elem.style.width  = (this.right - this.left) + "px"
  this.elem.style.height = (this.bottom - this.top) + "px"
}

