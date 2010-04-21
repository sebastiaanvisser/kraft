function RenderableEllipse (canvas, renderer)
{
  this.canvas   = canvas
  this.renderer = renderer
  this.elem     = this.setupElem()

  this.onchange(function () { this.renderer.enqueue(this) })
  this.changed()
}

RenderableEllipse.make =
function make (canvas, renderer, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableEllipse, canvas, renderer)
  return r
}

addToProto(RenderableEllipse,

  function setupElem ()
  {
    var elem = document.createElement("div")
    elem.setAttribute("class", "ellipse")
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
    this.canvas.removeChild(this.elem)
  }

)

function AdjustableEllipse () {}

AdjustableEllipse.make =
function make (canvas, renderer, x0, y0, x1, y1)
{
  var r = RenderableEllipse.make(canvas, renderer, x0, y0, x1, y1)
  r.decorate(AdjustableEllipse)
  return r
}

addToProto(AdjustableEllipse,

  function mkHandles ()
  {
    this.handles =
      { topLeft     : new Handle(this.canvas, this.renderer, this.p0)
      , topRight    : new Handle(this.canvas, this.renderer, this.p1)
      , bottomLeft  : new Handle(this.canvas, this.renderer, this.p2)
      , bottomRight : new Handle(this.canvas, this.renderer, this.p3)
      , midLeft     : new Handle(this.canvas, this.renderer, this.midLeft)
      , midRight    : new Handle(this.canvas, this.renderer, this.midRight)
      , midTop      : new Handle(this.canvas, this.renderer, this.midTop)
      , midBottom   : new Handle(this.canvas, this.renderer, this.midBottom)
      , center      : new Handle(this.canvas, this.renderer, this.center)
      }
  },

  function delHandles ()
  {
    foreach(this.handles, function (h) { h.destructor() })
  }

)

