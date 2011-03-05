function Rect (revive, ctx, x0, y0, x1, y1)
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

  this.def("br_x", 0)
  this.def("br_y", 10)
  this.def("br", Point.make(20, 400))
  C.add0(this.br.$.y, this.topLeft.$.y, this.$.br_y)
  C.add0(this.br.$.x, this.$.br_x, this.topLeft.$.x)

  this.def("bd_x", 0)
  this.def("bd_y", 10)
  this.def("bd", Point.make(20, 400))
  C.add0(this.bd.$.y, this.midLeft.$.y, this.$.bd_y)
  C.add0(this.bd.$.x, this.$.bd_x, this.topLeft.$.x)
}

Base.register(Rect)

Static(Rect,

  function make (x0, y0, x1, y1)
  {
    var r = new Base
    r.decorate(Rect, null, x0, y0, x1, y1)
    return r
  }

)

// ----------------------------------------------------------------------------

function RenderableRect (revive, ctx)
{
  this.canvas   = ctx
  this.elem     = this.setupElem()
  this.render()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

Base.register(RenderableRect)

Class(RenderableRect,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("rect")
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

    this.elem.style.borderTopLeftRadius     =
    this.elem.style.borderTopRightRadius    =
    this.elem.style.borderBottomLeftRadius  =
    this.elem.style.borderBottomRightRadius = (this.br_x >= 0 ? this.br_x : Math.round(-this.br_x / 5)) + "px"

    this.elem.style.borderWidth = (this.bd_x >= 0 ? this.bd_x : Math.round(-this.bd_x / 5)) + "px"
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function AdjustableRect ()
{
  this.adjusting = false
  this.selectable(this.mkHandles, this.delHandles)
}

Base.register(AdjustableRect)

Class(AdjustableRect,

  function mkHandles ()
  {
    // if (keys(this.canvas.selection.selected).length > 1) return
    this.handles = new Base
    this.handles.def("topLeft",     Handle.make           (this.canvas, this.p0))
    this.handles.def("topRight",    Handle.make           (this.canvas, this.p1))
    this.handles.def("bottomLeft",  Handle.make           (this.canvas, this.p2))
    this.handles.def("bottomRight", Handle.make           (this.canvas, this.p3))
    this.handles.def("midLeft",     HorizontalHandle.make (this.canvas, this.midLeft))
    this.handles.def("midRight",    HorizontalHandle.make (this.canvas, this.midRight))
    this.handles.def("midTop",      VerticalHandle.make   (this.canvas, this.midTop))
    this.handles.def("midBottom",   VerticalHandle.make   (this.canvas, this.midBottom))
    this.handles.def("center",      Handle.make           (this.canvas, this.center))

    this.handles.def("br",          HorizontalHandle.make (this.canvas, this.br))
    this.handles.def("bd",          HorizontalHandle.make (this.canvas, this.bd))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

