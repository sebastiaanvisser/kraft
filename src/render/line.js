function RenderableLine (canvas)
{
  this.canvas = canvas
  this.elem   = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

RenderableLine.make =
function make (canvas, x0, y0, x1, y1, w)
{
  var r = Line.make(x0, y0, x1, y1, w)
  r.decorate(RenderableLine, canvas)
  return r
}

Class(RenderableLine,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("line")
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
    var x0 = this.p0.x,
        y0 = this.p0.y,
        x1 = this.p1.x,
        y1 = this.p1.y,
        w  = this.width
    var len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    var rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI
    this.elem.style.left   = ((x0 + x1 - len) / 2) + "px"
    this.elem.style.top    = ((y0 + y1 - w)   / 2) + "px"
    this.elem.style.width  = len                   + "px"
    this.elem.style.height = w                     + "px"

    this.elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

function AdjustableLine () {}

AdjustableLine.make =
function make (canvas, x0, y0, x1, y1, w)
{
  var r = RenderableLine.make(canvas, x0, y0, x1, y1, w)
  r.decorate(AdjustableLine)
  return r
}

Class(AdjustableLine,

  function mkHandles ()
  {
    this.handles = new Base
    this.handles.def("topLeft",     Handle.make(this.canvas, this.p0))
    this.handles.def("bottomRight", Handle.make(this.canvas, this.p1))
    this.handles.def("center",      Handle.make(this.canvas, this.center))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

