function RenderableLine (canvas, renderer)
{
  this.canvas   = canvas
  this.renderer = renderer
  this.elem   = this.setupElem()

  this.onchange(function () { this.renderer.enqueue(this) })
  this.changed()
}

RenderableLine.make =
function make (canvas, renderer, x0, y0, x1, y1, w)
{
  var r = Line.make(x0, y0, x1, y1, w)
  r.decorate(RenderableLine, canvas, renderer)
  return r
}

addToProto(RenderableLine,

  function setupElem ()
  {
    var elem = document.createElement("div")
    elem.setAttribute("class", "line shape")
    elem.style.position = "absolute"
    this.canvas.appendChild(elem)
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
    this.canvas.removeChild(this.elem)
  }

)

function AdjustableLine () {}

AdjustableLine.make =
function make (canvas, renderer, x0, y0, x1, y1, w)
{
  var r = RenderableLine.make(canvas, renderer, x0, y0, x1, y1, w)
  r.decorate(AdjustableLine)
  return r
}

addToProto(AdjustableLine,

  function mkHandles ()
  {
    this.handles =
      { topLeft     : new Handle(this.canvas, this.renderer, this.p0)
      , bottomRight : new Handle(this.canvas, this.renderer, this.p1)
      , center      : new Handle(this.canvas, this.renderer, this.center)
      }
  },

  function delHandles ()
  {
    foreach(this.handles, function (h) { h.destructor() })
  }

)

