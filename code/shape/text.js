function Text (revive, ctx, x0, y0, x1, y1, text)
{
  if (!revive)
  {
    this.define("p0", Point.make(x0, y0))
    this.define("p1", Point.make(x1, y1))
    this.define("text", text)
  }

  Point.mid         (this.derive("center",      Point.make()).v, this.p0, this.p1)
  Point.topLeft     (this.derive("topLeft",     Point.make()).v, this.p0, this.p1)
  Point.bottomRight (this.derive("bottomRight", Point.make()).v, this.p0, this.p1)
  
  C.min0(this.derive("left",   0), this.p0.$.x, this.p1.$.x)
  C.min0(this.derive("top",    0), this.p0.$.y, this.p1.$.y)
  C.max0(this.derive("right",  0), this.p0.$.x, this.p1.$.x)
  C.max0(this.derive("bottom", 0), this.p0.$.y, this.p1.$.y)
}

Obj.register(Text)

Static(Text,

  function make (x0, y0, x1, y1, text)
  {
    var r = new Obj
    r.decorate(Text, null, x0, y0, x1, y1, text)
    return r
  }

)

// ----------------------------------------------------------------------------

function RenderableText (revive, ctx)
{
  this.canvas = ctx
  this.elem   = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.render()
}

Obj.register(RenderableText)

Static(RenderableText,

  function make (canvas, x0, y0, x1, y1, text)
  {
    var r = Text.make(x0, y0, x1, y1, text)
    r.decorate(RenderableText, canvas)
    return r
  }

)

Class(RenderableText,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("text")
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
    var x0 = this.p0.x,
        y0 = this.p0.y,
        x1 = this.p1.x,
        y1 = this.p1.y

    this.elem.innerHTML = this.text
    var w = this.elem.offsetWidth
    var h = this.elem.offsetHeight

    var len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    var rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI
    this.elem.style.left = ((x0 + x1 - w) / 2) + "px"
    this.elem.style.top  = ((y0 + y1 - h) / 2) + "px"
    // this.elem.style.width  = len                   + "px"


    this.elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function AdjustableText ()
{
  this.selectable(this.mkHandles, this.delHandles)
}

Obj.register(AdjustableText)

Static(AdjustableText,

  function make (canvas, x0, y0, x1, y1, text)
  {
    var r = RenderableText.make(canvas, x0, y0, x1, y1, text)
    r.decorate(SelectableShape)
    r.decorate(AdjustableText)
    return r
  }

)

Class(AdjustableText,

  function mkHandles ()
  {
    this.handles = new Obj
    this.handles.define("topLeft",     Handle.make(this.canvas, this.p0))
    this.handles.define("bottomRight", Handle.make(this.canvas, this.p1))
    this.handles.define("center",      Handle.make(this.canvas, this.center))
  },

  function delHandles ()
  {
    this.handles.destructor()
  }

)

