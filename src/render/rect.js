function RenderableRect (canvas)
{
  this.canvas   = canvas
  this.elem     = this.setupElem()
  this.render()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

RenderableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableRect, canvas)
  return r
}

addToProto(RenderableRect,

  function setupElem ()
  {
    var elem = document.createElement("div")
    elem.setAttribute("class", "rect shape")
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

function AdjustableRect () {}

AdjustableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableRect.make(canvas, x0, y0, x1, y1)
  r.decorate(AdjustableRect)
  return r
}

addToProto(AdjustableRect,

  function mkHandles ()
  {
    this.handles =
      { topLeft     : new Handle(this.canvas, this.p0)
      , topRight    : new Handle(this.canvas, this.p1)
      , bottomLeft  : new Handle(this.canvas, this.p2)
      , bottomRight : new Handle(this.canvas, this.p3)
      , midLeft     : new Handle(this.canvas, this.midLeft)
      , midRight    : new Handle(this.canvas, this.midRight)
      , midTop      : new Handle(this.canvas, this.midTop)
      , midBottom   : new Handle(this.canvas, this.midBottom)
      , center      : new Handle(this.canvas, this.center)
      }
  },

  function delHandles ()
  {
    foreach(this.handles, function (h) { h.destructor() })
  }

)

function DraggableRect ()
{
  this.dragger = new Draggable(this.canvas.elem, this, this.elem, false, false, 5, 5)
}

