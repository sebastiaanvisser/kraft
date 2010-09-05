function RenderableEllipse (revive, ctx)
{
  this.canvas = ctx
  this.elem   = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

Base.register(RenderableEllipse)

RenderableEllipse.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableEllipse, canvas)
  return r
}

Class(RenderableEllipse,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("ellipse")
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
    var w = this.right  - this.left
    var h = this.bottom - this.top

    this.elem.style.left   = this.left + "px"
    this.elem.style.top    = this.top  + "px"
    this.elem.style.width  = w         + "px"
    this.elem.style.height = h         + "px"

    this.elem.style.borderTopLeftRadius     =
    this.elem.style.borderTopRightRadius    =
    this.elem.style.borderBottomLeftRadius  =
    this.elem.style.borderBottomRightRadius = w/2 + "px " + h/2 + "px "
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

function AdjustableEllipse ()
{
  this.selectable(this.mkHandles, this.delHandles)
}

Base.register(AdjustableEllipse)

AdjustableEllipse.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableEllipse.make(canvas, x0, y0, x1, y1)
  r.decorate(SelectableRect)
  r.decorate(AdjustableEllipse)
  return r
}

Class(AdjustableEllipse,

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

