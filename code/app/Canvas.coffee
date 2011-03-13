Module "Canvas"

Import "base.Obj"
Import "Renderer"
Import "Model"

Class

  Canvas: (container) ->
    @container  = $ container
    @zoomBox    = $(".zoombox", container)[0]
    @canvasElem = $(".canvas", container)[0]
    @gridElem   = $(".grid", container)[0]
    @model      = Model.make @

    @renderer   = new Renderer
    @layers     = {}

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

  init: ->
    Obj.register Canvas

  make: (container) ->
    r = new Obj
    r.decorate Canvas, null, container
    r

