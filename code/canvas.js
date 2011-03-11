Module("Canvas")

Import("base.Obj")
Import("Renderer")
Import("Model")

Class
(

  function Canvas (container)
  {
    this.container  = $(container)
    this.zoomBox    = $(".zoombox", container)[0]
    this.canvasElem = $(".canvas", container)[0]
    this.gridElem   = $(".grid", container)[0]
    this.model      = Model.make(this)

    this.renderer   = new Renderer
    this.layers     = {}

    this.define("zoom",     1)
    this.define("gridSnap", 10)
    this.define("gridShow", true)
  },

  function showGrid () { this.gridShow = true;  $(this.gridElem).addClass    ("grid") },
  function hideGrid () { this.gridShow = false; $(this.gridElem).removeClass ("grid") },

  function zoomIn    () { $(this.zoomBox).css("zoom", this.zoom *= 2) },
  function zoomOut   () { $(this.zoomBox).css("zoom", this.zoom /= 2) },
  function zoomReset () { $(this.zoomBox).css("zoom", this.zoom = 1 ) }

)

Static(

  function init ()
  {
    Obj.register(Canvas)
  },

  function make (container)
  {
    var r = new Obj
    r.decorate(Canvas, null, container)
    return r
  }

)

