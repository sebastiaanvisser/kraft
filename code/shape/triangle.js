Module("shape.Triangle")

Import("base.Obj")

Class
(

  function Triangle (revive, ctx, x0, y0, x1, y1)
  {
    if (!revive)
    {
      this.define("p0", Point.make(x0, y0))
      this.define("p3", Point.make(x1, y1))
    }

    Point.yx(this.derive("p1", Point.make()).v, this.p0, this.p3)
    Point.xy(this.derive("p2", Point.make()).v, this.p0, this.p3)

    Point.mid          (this.derive("center",      Point.make()).v, this.p0, this.p3     )
    Point.topLeft      (this.derive("topLeft",     Point.make()).v, this.p0, this.p3     )
    Point.topRight     (this.derive("topRight",    Point.make()).v, this.p0, this.p3     )
    Point.bottomLeft   (this.derive("bottomLeft",  Point.make()).v, this.p0, this.p3     )
    Point.bottomRight  (this.derive("bottomRight", Point.make()).v, this.p0, this.p3     )
    Point.xy           (this.derive("midLeft",     Point.make()).v, this.p0, this.center )
    Point.xy           (this.derive("midRight",    Point.make()).v, this.p1, this.center )
    Point.yx           (this.derive("midTop",      Point.make()).v, this.p0, this.center )
    Point.yx           (this.derive("midBottom",   Point.make()).v, this.p2, this.center )

    C.sub0(this.derive("width",   0), this.bottomRight.$.x, this.topLeft.$.x )
    C.sub0(this.derive("height",  0), this.bottomRight.$.y, this.topLeft.$.y )
    C.min0(this.derive("left",    0), this.p0.$.x,          this.p3.$.x      )
    C.min0(this.derive("top",     0), this.p0.$.y,          this.p3.$.y      )
    C.max0(this.derive("right",   0), this.p0.$.x,          this.p3.$.x      )
    C.max0(this.derive("bottom",  0), this.p0.$.y,          this.p3.$.y      )
  }

)

Static
(

  function init ()
  {
    Obj.register(Triangle)
  },

  function make (x0, y0, x1, y1)
  {
    var r = new Obj
    r.decorate(Triangle, null, x0, y0, x1, y1)
    return r
  }

)

Module("shape.RenderableTriangle")

Import("base.Obj")

Class
(

  function RenderableTriangle (revive, model)
  {
    this.model = model
    this.setupElem()

    this.onchange(function () { this.model.canvas.renderer.enqueue(this) })
    this.render()
  },

  function setupElem ()
  {
    var elem = this.elem = document.createElement("div")
    $(elem).addClass("triangle")
    elem.style.position = "absolute"
    this.model.canvas.canvasElem.appendChild(elem)

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
    this.model.canvas.canvasElem.removeChild(this.elem)
  }

)

Static
(

  function init ()
  {
    Obj.register(RenderableTriangle)
  },

  function make (model, x0, y0, x1, y1)
  {
    var r = Triangle.make(x0, y0, x1, y1)
    r.decorate(RenderableTriangle, model)
    return r
  }

)

Module("shape.AdjustableTriangle")

Import("base.Obj")

Class
(

  function AdjustableTriangle ()
  {
    this.selectable(this.mkHandles, this.delHandles)
  },

  function mkHandles ()
  {
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
    Obj.register(AdjustableTriangle)
  },

  function make (model, x0, y0, x1, y1)
  {
    var r = RenderableTriangle.make(model, x0, y0, x1, y1)
    r.decorate(SelectableShape)
    r.decorate(AdjustableTriangle)
    return r
  }

)

