function RenderableEllipse () {}

RenderableEllipse.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Shape.make(x0, y0, x1, y1)
  r.decorate(RenderableEllipse, canvas)
  return r
}

addToProto(RenderableEllipse,

  function constructor (canvas)
  {
    this.canvas = canvas
    this.elem   = this.setupElem()
    this.render()

    this.onchange(this.render)
    this.render()
  },

  function setupElem ()
  {
    var elem = document.createElement("div")
    elem.setAttribute("class", "ellipse shape")
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
    var w = this.right.get()  - this.left.get();
    var h = this.bottom.get() - this.top.get();

    this.elem.style.left   = this.left.get() + "px"
    this.elem.style.top    = this.top.get()  + "px"
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
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableEllipse.make(canvas, x0, y0, x1, y1)
  r.decorate(AdjustableEllipse)
  return r
}

addToProto(AdjustableEllipse,

  function mkHandles ()
  {
    var self = this
    function mkHandle ()
    {
      var h = RenderableEllipse.make(this.canvas, 0, 0, 8, 8)
      h.decorate(DraggableShape)
      h.elem.className += " handle"
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

    Point.eq(this.handles.topLeft.center.get(),     this.p0)
    Point.eq(this.handles.topRight.center.get(),    this.p1)
    Point.eq(this.handles.bottomLeft.center.get(),  this.p2)
    Point.eq(this.handles.bottomRight.center.get(), this.p3)
    Point.eq(this.handles.midLeft.center.get(),     this.midLeft.get())
    Point.eq(this.handles.midRight.center.get(),    this.midRight.get())
    Point.eq(this.handles.midTop.center.get(),      this.midTop.get())
    Point.eq(this.handles.midBottom.center.get(),   this.midBottom.get())
  },

  function delHandles ()
  {
    for (var p in this.handles)
      this.handles[p].destructor()
  }

)

