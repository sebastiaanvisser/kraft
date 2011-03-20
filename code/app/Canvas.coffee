Module "Canvas"

Import "base.Obj"
Import "Renderer"

Class

  Canvas: (revive, container) ->

    # Setup HTML canvas elements.
    @container  = container
    @zoomBox    = $(".zoombox", container)[0]
    @elem       = $(".canvas", container)[0]
    @gridElem   = $(".grid", container)[0]

    # Setup a rendere specific for this canvas.
    @renderer   = new Renderer

    # Define canvas geometry.
    @define "width",  4000
    @define "height", 4000
    @setSize()

    # Define canvas grid.
    @define "zoom",     1
    @define "gridSnap", 10
    @define "gridShow", true

    # Track changes.
    @onchange => @setSize()
    @onchange => @setZoom()
    @onchange => @setGrid()

    @

  setSize: ->
    for e in [@gridElem, @elem]
      ($ e).css "width",  @width
      ($ e).css "height", @height

  setZoom: -> ($ @zoomBox).css "zoom", @zoom

  setGrid: ->
    if @gridShow
      ($ @gridElem).addClass "grid"
    else
      ($ @gridElem).removeClass "grid"

Static

  init: -> Obj.register Canvas

  make: (container) -> (new Obj "Canvas").decorate Canvas, container

