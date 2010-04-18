Shape.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  this.canvas.appendChild(elem)
  return elem
}









Shape.prototype.renderable =
function renderable (canvas)
{
  this.canvas = canvas
  this.elem   = this.setupElem()
  this.render()

  this.onchange(this.render)
}

Shape.prototype.render =
function render ()
{
  this.elem.style.left   = this.left.get()   + "px"
  this.elem.style.top    = this.top.get()    + "px"
  this.elem.style.width  = this.width.get()  + "px"
  this.elem.style.height = this.height.get() + "px"
}

Shape.prototype.unrender =
function unrender ()
{
  this.canvas.removeChild(this.elem)
}

// --------------------------

Shape.prototype.mkHandles =
function mkHandles ()
{
  var self = this
  function mkHandle ()
  {
    var h = new Shape(0, 0, 8, 8)
    h.renderable(self.canvas)
    h.elem.className += " handle"
    new Draggable(h.canvas, h, h.elem, false, false, 5, 5)
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

Shape.prototype.removeHandles =
function removeHandles ()
{
  for (var p in this.handles)
    this.handles[p].destruct()
}

