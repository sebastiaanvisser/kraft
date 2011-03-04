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
}

Base.register(Rect)

Rect.make =
function make (x0, y0, x1, y1)
{
  var r = new Base
  r.decorate(Rect, null, x0, y0, x1, y1)
  return r
}

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

RenderableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = Rect.make(x0, y0, x1, y1)
  r.decorate(RenderableRect, canvas)
  return r
}

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
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

// ----------------------------------------------------------------------------

function SelectableRect ()
{
  this.onselect   = []
  this.ondeselect = []

  var sel = this.canvas.selection
  sel.selectable[this.id] = this

  var self = this
  Events.manager.bind(this.canvas.elem, "mousedown",
    function (e) { sel.deselectAll() })
  Events.manager.bind(this.elem, "mousedown",
    function (e)
    {
      if (e.altKey) return sel.deselect(self)
      if (!e.shiftKey) sel.deselectAll() // TODO: don't select when is equal to new selection
      sel.select(self)
    })

  this.selectable
    ( function () { $(self.elem).addClass("selected")    }
    , function () { $(self.elem).removeClass("selected") }
    )
}

Base.register(SelectableRect)

Class(SelectableRect,

  function selectable (s, d)
  {
    this.onselect.push(s)
    this.ondeselect.push(d)
  },

  function select ()
  {
    this.canvas.selection.select(this)
  },

  function deselect ()
  {
    this.canvas.selection.deselect(this)
  }

)

// ----------------------------------------------------------------------------

function AdjustableRect ()
{
  this.selectable(this.mkHandles, this.delHandles)
}

Base.register(AdjustableRect)

AdjustableRect.make =
function make (canvas, x0, y0, x1, y1)
{
  var r = RenderableRect.make(canvas, x0, y0, x1, y1)
  r.decorate(SelectableRect)
  r.decorate(AdjustableRect)
  return r
}

Class(AdjustableRect,

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

