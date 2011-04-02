Module "Canvas"

Import "base.Obj"
Import "shape.Rect"
Import "Renderer"
Qualified "Events"

Register "Obj"
Class

  Canvas: (container) ->

    # Setup HTML canvas elements.
    @container = container
    @zoomBox   = $(".zoombox", @container)[0]
    @elem      = $(".canvas", @container)[0]
    @gridElem  = $(".grid", @container)[0]

    # Setup a rendere specific for this canvas.
    @renderer  = new Renderer

    # Define canvas geometry.
    @define width:  4000
    @define height: 4000
    @setSize()

    # Define active viewport.
    @define viewport: mk Rect, 0, 0, 100, 100
    Events.manager.bind $(@container), "scroll", => @setViewport()

    # Define canvas grid.
    @define zoom:     1
    @define gridSnap: 10
    @define gridShow: true

    # Track changes.
    @onchange => @setSize()
    @onchange => @setZoom()
    @onchange => @setGrid()

    @

  setSize: ->
    for e in [@gridElem, @elem]
      $(e).css "width",  @width
      $(e).css "height", @height

  setZoom: -> $(@zoomBox).css "zoom", @zoom

  setGrid: ->
    g = $ @gridElem
    if @gridShow then g.addClass "grid" else g.removeClass "grid"

  setViewport: ->
    @viewport.p0.x   = @container.scrollLeft   / @zoom
    @viewport.p0.y   = @container.scrollTop    / @zoom
    @viewport.width  = @container.clientWidth  / @zoom
    @viewport.height = @container.clientHeight / @zoom

