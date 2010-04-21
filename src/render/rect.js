function RenderableRect (canvas, renderer)
{
  this.canvas   = canvas
  this.renderer = renderer
  this.elem     = this.setupElem()
  this.render()

  this.onchange(function () { this.renderer.enqueue(this) })
  this.changed()
}

RenderableRect.make =
function make (canvas, renderer, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableRect, canvas, renderer)
  return r
}

addToProto(RenderableRect,

  function setupElem ()
  {
    var elem = document.createElement("div")
    elem.setAttribute("class", "rect shape")
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
    this.elem.style.left   = this.left   + "px"
    this.elem.style.top    = this.top    + "px"
    this.elem.style.width  = this.width  + "px"
    this.elem.style.height = this.height + "px"
  },

  function unrender ()
  {
    this.canvas.removeChild(this.elem)
  }

)

function AdjustableRect () {}

AdjustableRect.make =
function make (canvas, renderer, x0, y0, x1, y1)
{
  var r = RenderableRect.make(canvas, renderer, x0, y0, x1, y1)
  r.decorate(AdjustableRect)
  return r
}

addToProto(AdjustableRect,

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

function DraggableRect ()
{
  this.dragger = new Draggable(this.canvas, this, this.elem, false, false, 10, 10)
}

