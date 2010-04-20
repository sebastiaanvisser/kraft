function RenderableRect ()
{
  this.canvas = canvas
  this.elem   = this.setupElem()
  this.render()

  this.onchange(this.render)
  this.render()
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
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableRect.make(canvas, x0, y0, x1, y1)
  r.decorate(AdjustableRect)
  return r
}

addToProto(AdjustableRect,

  function mkHandles ()
  {
    var self = this
    function mkHandle ()
    {
      var h = RenderableRect.make(this.canvas, 0, 0, 8, 8)
      h.decorate(DraggableRect)
      h.elem.className += " handle"
      return h
    }

    this.handles =
      { topLeft     : mkHandle()
      , topRight    : mkHandle()
      , bottomLeft  : mkHandle()
      , bottomRight : mkHandle()
      , midLeft     : mkHandle()
      , midRight    : mkHandle()
      , midTop      : mkHandle()
      , midBottom   : mkHandle()
      , center      : mkHandle()
      }

    Point.eq(this.handles.topLeft.center,     this.p0)
    Point.eq(this.handles.topRight.center,    this.p1)
    Point.eq(this.handles.bottomLeft.center,  this.p2)
    Point.eq(this.handles.bottomRight.center, this.p3)
    Point.eq(this.handles.midLeft.center,     this.midLeft)
    Point.eq(this.handles.midRight.center,    this.midRight)
    Point.eq(this.handles.midTop.center,      this.midTop)
    Point.eq(this.handles.midBottom.center,   this.midBottom)
    Point.eq(this.handles.center.center,      this.center)
  },

  function delHandles ()
  {
    for (var p in this.handles)
      this.handles[p].destructor()
  }

)

function DraggableRect ()
{
  this.dragger = new Draggable(this.canvas, this, this.elem, false, false, 10, 10)
}

