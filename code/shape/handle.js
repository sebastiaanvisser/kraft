function Handle (revive, ctx, pt)
{
  this.canvas = ctx
  this.pt     = pt

  this.defHandlePoint("handle", 0, 0, 10, 10)
}

Obj.register(Handle)

Class(Handle,

  function defHandlePoint (prop, x, y, w, h)
  {
    this.define(prop, Rect.make(x, y, w, h))
    this[prop].decorate(RenderableEllipse, this.canvas)
    this[prop].decorate(DraggableShape)
    $(this[prop].elem).addClass(prop)
    Point.eq(this[prop].center, this.pt)
  }

)

Handle.make =
function make (canvas, pt)
{
  var h = new Obj
  h.decorate(Handle, canvas, pt)
  return h
}

// ----------------------------------------------------------------------------

function VerticalHandle ()
{
  this.defHandlePoint("handleV", 0, 0, 2, 16)
  this.handle.dragger.lockX  = true
  this.handleV.dragger.lockX = true
}

Static(VerticalHandle,

  function make (canvas, pt)
  {
    var h = Handle.make(canvas, pt)
    h.decorate(VerticalHandle)
    return h
  }

)

// ----------------------------------------------------------------------------

function HorizontalHandle ()
{
  this.defHandlePoint("handleH", 0, 0, 16, 2)
  this.handle.dragger.lockY  = true
  this.handleH.dragger.lockY = true
}

Static(HorizontalHandle, 

  function make (canvas, pt)
  {
    var h = Handle.make(canvas, pt)
    h.decorate(HorizontalHandle)
    return h
  }

)

