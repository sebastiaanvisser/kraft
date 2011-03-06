function Line (revive, _, x0, y0, x1, y1, w)
{
  if (!revive)
  {
    this.define("p0", Point.make(x0, y0))
    this.define("p1", Point.make(x1, y1))
    this.define("width", w)
  }

  Point.mid         (this.derive("center",      Point.make()).v, this.p0, this.p1)
  Point.topLeft     (this.derive("topLeft",     Point.make()).v, this.p0, this.p1)
  Point.bottomRight (this.derive("bottomRight", Point.make()).v, this.p0, this.p1)
  
  C.min0(this.define("left",   0), this.p0.$.x, this.p1.$.x)
  C.min0(this.define("top",    0), this.p0.$.y, this.p1.$.y)
  C.max0(this.define("right",  0), this.p0.$.x, this.p1.$.x)
  C.max0(this.define("bottom", 0), this.p0.$.y, this.p1.$.y)
}

Obj.register(Line)

Static(Line,

  function make (x0, y0, x1, y1, w)
  {
    var r = new Obj
    r.decorate(Line, null, x0, y0, x1, y1, w)
    return r
  }

)

// ----------------------------------------------------------------------------

function RenderableLine (revive, model)
{
  this.model  = model
  this.canvas = this.model.canvas
  this.elem   = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.render()
}

Obj.register(RenderableLine)

Static(RenderableLine,

  function make (canvas, x0, y0, x1, y1, w)
  {
    var r = Line.make(x0, y0, x1, y1, w)
    r.decorate(RenderableLine, canvas)
    return r
  }

)

Class(RenderableLine,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("line")
    elem.style.position = "absolute"
    this.canvas.canvasElem.appendChild(elem)
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
    this.canvas.canvasElem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function AdjustableLine ()
{
  this.selectable(this.mkHandles, this.delHandles)
}

Obj.register(AdjustableLine)

Static(AdjustableLine,

  function make (model, x0, y0, x1, y1, w)
  {
    var r = RenderableLine.make(model, x0, y0, x1, y1, w)
    r.decorate(SelectableShape)
    r.decorate(AdjustableLine)
    return r
  }

)

Class(AdjustableLine,

  function mkHandles ()
  {
    this.handles = new Obj
    this.handles.define("topLeft",     Handle.make(this.model, this.p0))
    this.handles.define("bottomRight", Handle.make(this.model, this.p1))
    this.handles.define("center",      Handle.make(this.model, this.center))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

