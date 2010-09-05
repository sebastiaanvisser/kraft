function RenderableRect (canvas)
{
  this.canvas   = canvas
  this.elem     = this.setupElem()
  this.render()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

Base.register(RenderableRect)

RenderableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableRect, canvas)
  return r
}

Class(RenderableRect,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("rect")
    elem.style.position = "absolute"
    this.canvas.elem.appendChild(elem)
    return elem
  },

  function destructor ()
  {
    this.unrender()
  },

  function render ()
  {
    this.elem.style.left   = this.left   + "px"
    this.elem.style.top    = this.top    + "px"
    this.elem.style.width  = this.width  + "px"
    this.elem.style.height = this.height + "px"
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function AdjustableRect () {}

Base.register(AdjustableRect)

AdjustableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableRect.make(canvas, x0, y0, x1, y1)
  r.decorate(AdjustableRect)
  return r
}

Class(AdjustableRect,

  function mkHandles ()
  {
    this.handles = new Base
    this.handles.def("topLeft",     Handle.make  (this.canvas, this.p0))
    this.handles.def("topRight",    Handle.make  (this.canvas, this.p1))
    this.handles.def("bottomLeft",  Handle.make  (this.canvas, this.p2))
    this.handles.def("bottomRight", Handle.make  (this.canvas, this.p3))
    this.handles.def("midLeft",     Handle.makeH (this.canvas, this.midLeft))
    this.handles.def("midRight",    Handle.makeH (this.canvas, this.midRight))
    this.handles.def("midTop",      Handle.makeV (this.canvas, this.midTop))
    this.handles.def("midBottom",   Handle.makeV (this.canvas, this.midBottom))
    this.handles.def("center",      Handle.make  (this.canvas, this.center))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

// ----------------------------------------------------------------------------

function DraggableRect ()
{
  this.dragger = new Draggable(this.canvas.elem, this, this.elem, false, false, 5, 5)
}

Base.register(DraggableRect)

