function Triangle (revive, ctx, x0, y0, x1, y1)
{
  if (!revive)
  {
    this.def("p0", Point.make(x0, y0))
    this.def("p3", Point.make(x1, y1))
  }

  this.def1("p1", Point.make(), Point.yx, this.p0, this.p3)
  this.def1("p2", Point.make(), Point.xy, this.p0, this.p3)

  this.def1("center",      Point.make(), Point.mid,         this.p0, this.p3     )
  this.def1("topLeft",     Point.make(), Point.topLeft,     this.p0, this.p3     )
  this.def1("topRight",    Point.make(), Point.topRight,    this.p0, this.p3     )
  this.def1("bottomLeft",  Point.make(), Point.bottomLeft,  this.p0, this.p3     )
  this.def1("bottomRight", Point.make(), Point.bottomRight, this.p0, this.p3     )
  this.def1("midLeft",     Point.make(), Point.xy,          this.p0, this.center )
  this.def1("midRight",    Point.make(), Point.xy,          this.p1, this.center )
  this.def1("midTop",      Point.make(), Point.yx,          this.p0, this.center )
  this.def1("midBottom",   Point.make(), Point.yx,          this.p2, this.center )

  this.def("width",   0, C.sub0, this.bottomRight.$.x, this.topLeft.$.x )
  this.def("height",  0, C.sub0, this.bottomRight.$.y, this.topLeft.$.y )
  this.def("left",    0, C.min0, this.p0.$.x,          this.p3.$.x      )
  this.def("top",     0, C.min0, this.p0.$.y,          this.p3.$.y      )
  this.def("right",   0, C.max0, this.p0.$.x,          this.p3.$.x      )
  this.def("bottom",  0, C.max0, this.p0.$.y,          this.p3.$.y      )
}

Base.register(Triangle)

Triangle.make =
function make (x0, y0, x1, y1)
{
  var r = new Base
  r.decorate(Triangle, null, x0, y0, x1, y1)
  return r
}

// ----------------------------------------------------------------------------

function RenderableTriangle (revive, ctx)
{
  this.canvas = ctx
  this.setupElem()
  this.render()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

Base.register(RenderableTriangle)

RenderableTriangle.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Triangle.make(x0, y0, x1, y1)
  r.decorate(RenderableTriangle, canvas)
  return r
}

Class(RenderableTriangle,

  function setupElem ()
  {
    var elem = this.elem = document.createElement("div")
    $(elem).addClass("triangle")
    elem.style.position = "absolute"
    this.canvas.elem.appendChild(elem)

    var elem1 = this.elem1 = document.createElement("div")
    $(elem1).addClass("inner-triangle")
    elem1.style.position = "absolute"
    elem.appendChild(elem1)
  },

  function destructor ()
  {
    this.unrender()
  },

  function render ()
  {
    this.elem.style.left   = this.left     + "px"
    this.elem.style.top    = this.top      + "px"
    this.elem.style.width  = this.width    + "px"
    this.elem.style.height = this.height   + "px"

    var x0 = this.p0.x,
        y0 = this.p0.y,
        x1 = this.p3.x,
        y1 = this.p3.y
    var len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    var rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI

    var left = (x1 > x0 ? 1 : -1) * (this.center.x - this.left)

    this.elem1.style.left   = left          + "px"
    this.elem1.style.top    = 0             + "px"
    this.elem1.style.width  = this.width    + "px"
    this.elem1.style.height = this.height   + "px"

    this.elem1.style["-webkit-transform"] = "skew(" + (90+rot) + "deg)"
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function AdjustableTriangle ()
{
  this.selectable(this.mkHandles, this.delHandles)
}

Base.register(AdjustableTriangle)

AdjustableTriangle.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableTriangle.make(canvas, x0, y0, x1, y1)
  r.decorate(SelectableRect)
  r.decorate(AdjustableTriangle)
  return r
}

Class(AdjustableTriangle,

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

