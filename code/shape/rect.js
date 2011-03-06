function Rect (revive, ctx, x0, y0, x1, y1)
{
  if (!revive)
  {
    this.def("p0",     Point.make(x0, y0))
    this.def("p3",     Point.make(x1, y1))
    this.def("radius", 0)
    this.def("border", 5)
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

Obj.register(Rect)

Static(Rect,

  function make (x0, y0, x1, y1)
  {
    var r = new Obj
    r.decorate(Rect, null, x0, y0, x1, y1)
    return r
  }

)

// ----------------------------------------------------------------------------

function RenderableRect (revive, ctx)
{
  this.canvas   = ctx
  this.elem     = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.render()
}

Obj.register(RenderableRect)

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

    var r = (this.radius >= 0 ? this.radius : Math.round(-this.radius / 5)) + "px"
    this.elem.style.borderTopLeftRadius     =
    this.elem.style.borderTopRightRadius    =
    this.elem.style.borderBottomLeftRadius  =
    this.elem.style.borderBottomRightRadius = r

    var b = (this.border >= 0 ? this.border : Math.round(-this.border / 5)) + "px"
    this.elem.style.borderWidth = b
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

Obj.register(AdjustableRect)

Class(AdjustableRect,

  function mkHandles ()
  {
    // if (keys(this.canvas.selection.selected).length > 1) return
    this.handles = new Obj
    this.handles.def("topLeft",     Handle.make           (this.canvas, this.p0))
    this.handles.def("topRight",    Handle.make           (this.canvas, this.p1))
    this.handles.def("bottomLeft",  Handle.make           (this.canvas, this.p2))
    this.handles.def("bottomRight", Handle.make           (this.canvas, this.p3))
    this.handles.def("midLeft",     HorizontalHandle.make (this.canvas, this.midLeft))
    this.handles.def("midRight",    HorizontalHandle.make (this.canvas, this.midRight))
    this.handles.def("midTop",      VerticalHandle.make   (this.canvas, this.midTop))
    this.handles.def("midBottom",   VerticalHandle.make   (this.canvas, this.midBottom))
    this.handles.def("center",      Handle.make           (this.canvas, this.center))

    var radiusH = Point.make()
    C.add0(radiusH.$.y, this.topLeft.$.y, val(10))
    C.add0(radiusH.$.x, this.$.radius, this.topLeft.$.x)
    this.handles.def("radiusH", HorizontalHandle.make (this.canvas, radiusH))

    var borderH = Point.make()
    C.add0(borderH.$.x, this.$.border, this.topLeft.$.x)
    C.add0(borderH.$.y, this.midLeft.$.y, val(10))
    this.handles.def("borderH", HorizontalHandle.make (this.canvas, borderH))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

