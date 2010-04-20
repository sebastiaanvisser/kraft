function RenderableLine (canvas)
{
  this.canvas = canvas
  this.elem   = this.setupElem()
  this.render()

  this.onchange(this.render)
  this.render()
}

RenderableLine.make =
function make (canvas, x0, y0, x1, y1, w)
{
  var r = Line.make(x0, y0, x1, y1, w)
  r.decorate(RenderableLine, canvas)
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
function make (canvas, x0, y0, x1, y1, w)
{
  var r = RenderableLine.make(canvas, x0, y0, x1, y1, w)
  r.decorate(AdjustableLine)
  return r
}

addToProto(AdjustableLine,

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

    this.handles = {}
    this.handles.topLeft     = mkHandle()
    this.handles.bottomRight = mkHandle()
    this.handles.center      = mkHandle()
    Point.eq(this.handles.topLeft.center,     this.p0)
    Point.eq(this.handles.bottomRight.center, this.p1)
    Point.eq(this.handles.center.center,      this.center)
  },

  function delHandles ()
  {
    for (var p in this.handles)
      this.handles[p].destructor()
  }

)
