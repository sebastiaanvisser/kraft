function Handle (canvas, renderer, pt)
{
  this.handle0 = RenderableEllipse.make(canvas, renderer, 0, 0, 11, 11)
  this.handle0.decorate(DraggableRect)
  this.handle0.elem.className += " handle0"

  this.handle1 = RenderableEllipse.make(canvas, renderer, 0, 0, 7, 7)
  this.handle1.decorate(DraggableRect)
  this.handle1.elem.className += " handle1"

  Point.eq(this.handle0.center, pt)
  Point.eq(this.handle1.center, pt)
}

addToProto(Handle,

  function destructor ()
  {
    this.handle0.destructor()
    this.handle1.destructor()
  }

)
