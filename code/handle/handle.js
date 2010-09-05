function Handle (canvas, pt)
{
  this.canvas = canvas
  this.pt     = pt

  this.def("handle0", RenderableEllipse.make(this.canvas, 0, 0, 10, 10))
  this.handle0.decorate(DraggableRect)
  $(this.handle0.elem).addClass("handle0")
  Point.eq(this.handle0.center, this.pt)

  this.def("handle1", RenderableEllipse.make(this.canvas, 0, 0, 6, 6))
  this.handle1.decorate(DraggableRect)
  $(this.handle1.elem).addClass("handle1")
  Point.eq(this.handle1.center, this.pt)
}

Base.register(Handle)

Handle.make =
function make (canvas, pt)
{
  var h = new Base
  h.decorate(Handle, canvas, pt)
  return h
}

Handle.makeV =
function makeV (canvas, pt)
{
  var h = Handle.make(canvas, pt)
  h.decorate(VeriticalHandle)
  return h
}

function VeriticalHandle ()
{
  this.def("handleV", RenderableRect.make(this.canvas, 0, 0, 2, 14))
  this.handleV.decorate(DraggableRect)
  $(this.handleV.elem).addClass("handle0")
  Point.eq(this.handleV.center, this.pt)

  this.handle0.dragger.lockX = true
  this.handle1.dragger.lockX = true
  this.handleV.dragger.lockX = true
}

Handle.makeH =
function makeH (canvas, pt)
{
  var h = Handle.make(canvas, pt)
  h.decorate(HorizontalHandle)
  return h
}

function HorizontalHandle ()
{
  this.def("handleH", RenderableRect.make(this.canvas, 0, 0, 14, 2))
  this.handleH.decorate(DraggableRect)
  $(this.handleH.elem).addClass("handle0")
  Point.eq(this.handleH.center, this.pt)

  this.handle0.dragger.lockY = true
  this.handle1.dragger.lockY = true
  this.handleH.dragger.lockY = true
}

