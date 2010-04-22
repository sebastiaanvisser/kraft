function Canvas (elem)
{
  this.elem      = elem
  this.selection = new Selection
  this.renderer  = new Renderer
  this.page      = Rect.make(0, 0, 800, 200)
  this.offset    = Point.make(0, 0)
  this.zoom      = 1
  this.gridSnap  = 10
  this.gridShow  = true
  this.layers    = {}
}

addToProto(Canvas,

  function showGrid ()
  {
    this.gridShow = true
    $(this.elem).addClass("grid")
  },

  function hideGrid ()
  {
    this.gridShow = false
    $(this.elem).removeClass("grid")
  }

)

