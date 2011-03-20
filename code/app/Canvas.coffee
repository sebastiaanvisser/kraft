Module "Canvas"

Import "base.Obj"
Import "Renderer"

Class

  Canvas: (revive, container) ->
    @container  = container
    @zoomBox    = $(".zoombox", container)[0]
    @elem       = $(".canvas", container)[0]
    @gridElem   = $(".grid", container)[0]

    @renderer   = new Renderer

    @define "zoom",     1
    @define "gridSnap", 10
    @define "gridShow", true
    @

  showGrid: -> @gridShow = true;  $(@gridElem).addClass    "grid"
  hideGrid: -> @gridShow = false; $(@gridElem).removeClass "grid"

  zoomIn:    -> $(@zoomBox).css "zoom", @zoom *= 2
  zoomOut:   -> $(@zoomBox).css "zoom", @zoom /= 2
  zoomReset: -> $(@zoomBox).css "zoom", @zoom = 1

Static

  init: -> Obj.register Canvas

  make: (container) -> (new Obj "Canvas").decorate Canvas, container

