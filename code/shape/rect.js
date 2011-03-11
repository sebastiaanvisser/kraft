Module("shape.Rect")

Import("base.Obj")
Import("constraint.Constraint")
Qualified("shape.Point", "Pt")
Qualified("constraint.Point", "Pc")

Class
(

  function Rect (revive, _, x0, y0, x1, y1)
  {
    if (!revive)
    {
      this.define("p0",     Pt.make(x0, y0))
      this.define("p3",     Pt.make(x1, y1))
      this.define("radius", 0)
      this.define("border", 5)
    }

    Pc.yx(this.derive("p1", Pt.make()).v, this.p0, this.p3)
    Pc.xy(this.derive("p2", Pt.make()).v, this.p0, this.p3)

    Pc.mid         (this.derive("center",      Pt.make()).v, this.p0, this.p3     )
    Pc.topLeft     (this.derive("topLeft",     Pt.make()).v, this.p0, this.p3     )
    Pc.topRight    (this.derive("topRight",    Pt.make()).v, this.p0, this.p3     )
    Pc.bottomLeft  (this.derive("bottomLeft",  Pt.make()).v, this.p0, this.p3     )
    Pc.bottomRight (this.derive("bottomRight", Pt.make()).v, this.p0, this.p3     )
    Pc.xy          (this.derive("midLeft",     Pt.make()).v, this.p0, this.center )
    Pc.xy          (this.derive("midRight",    Pt.make()).v, this.p1, this.center )
    Pc.yx          (this.derive("midTop",      Pt.make()).v, this.p0, this.center )
    Pc.yx          (this.derive("midBottom",   Pt.make()).v, this.p2, this.center )

    sub0(this.derive("width",  0), this.bottomRight.$.x, this.topLeft.$.x)
    sub0(this.derive("height", 0), this.bottomRight.$.y, this.topLeft.$.y )
    min0(this.derive("left",   0), this.p0.$.x,          this.p3.$.x      )
    min0(this.derive("top",    0), this.p0.$.y,          this.p3.$.y      )
    max0(this.derive("right",  0), this.p0.$.x,          this.p3.$.x      )
    max0(this.derive("bottom", 0), this.p0.$.y,          this.p3.$.y      )
  }

)

Static
(

  function init ()
  {
    Obj.register(Rect)
  },

  function make (x0, y0, x1, y1)
  {
    var r = new Obj
    r.decorate(Rect, null, x0, y0, x1, y1)
    return r
  }

)

// ----------------------------------------------------------------------------

Module("shape.RenderableRect")

Import("base.Obj")

Class
(

  function RenderableRect (revive, model)
  {
    this.model    = model
    this.elem     = this.setupElem()

    this.onchange(function () { this.model.canvas.renderer.enqueue(this) })
    this.render()
  },

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("rect")
    elem.style.position = "absolute"
    this.model.canvas.canvasElem.appendChild(elem)
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
    this.model.canvas.canvasElem.removeChild(this.elem)
  }

)

Static
(

  function init ()
  {
    Obj.register(RenderableRect)
  }

)

Module("shape.AdjustableRect")

Import("base.Obj")
Import("base.Value")
Import("constraint.Constraint")
Import("shape.Handle")
Import("shape.HorizontalHandle")
Import("shape.VerticalHandle")
Qualified("shape.Point", "Pt")

Class
(

  function AdjustableRect ()
  {
    this.adjusting = false
    this.selectable(this.mkHandles, this.delHandles)
  },

  function mkHandles ()
  {
    // if (keys(this.canvas.selection.selected).length > 1) return
    this.handles = new Obj
    this.handles.define("topLeft",     Handle.make           (this.model, this.p0))
    this.handles.define("topRight",    Handle.make           (this.model, this.p1))
    this.handles.define("bottomLeft",  Handle.make           (this.model, this.p2))
    this.handles.define("bottomRight", Handle.make           (this.model, this.p3))
    this.handles.define("midLeft",     HorizontalHandle.make (this.model, this.midLeft))
    this.handles.define("midRight",    HorizontalHandle.make (this.model, this.midRight))
    this.handles.define("midTop",      VerticalHandle.make   (this.model, this.midTop))
    this.handles.define("midBottom",   VerticalHandle.make   (this.model, this.midBottom))
    this.handles.define("center",      Handle.make           (this.model, this.center))

    var radiusH = Pt.make()
    add0(radiusH.$.y, this.topLeft.$.y, val(10))
    add0(radiusH.$.x, this.$.radius, this.topLeft.$.x)
    this.handles.define("radiusH", HorizontalHandle.make (this.model, radiusH))

    var borderH = Pt.make()
    add0(borderH.$.x, this.$.border, this.topLeft.$.x)
    add0(borderH.$.y, this.midLeft.$.y, val(10))
    this.handles.define("borderH", HorizontalHandle.make (this.model, borderH))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

Static
(

  function init ()
  {
    Obj.register(AdjustableRect)
  }

)

