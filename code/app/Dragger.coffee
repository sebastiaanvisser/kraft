Module "Dragger"

Qualified "Events", As "E"

Class

  Dragger: (container, target, pivot, lockX, lockY, snapX, snapY, zoom) ->

    # Dragging elements.
    @container = container
    @target    = target
    @pivot     = pivot
    @zoom      = zoom

    # Locking and snappig constraints.
    @lockX = lockX || false
    @lockY = lockY || false
    @snapX = snapX || 1
    @snapY = snapY || 1

    # Add a class indicating this element is draggable.
    $(@target.elem).addClass "draggable"

    # State, private.
    @dragging     = false
    @dragOrigin   = {}
    @targetOrigin = {}

    # Install event listeners.
    E.manager.bind pivot,     "mousedown", (e) => @startDrag(e)
    E.manager.bind container, "mouseup",   (e) => @stopDrag(e)
    E.manager.bind container, "mousemove", (e) => @drag(e)
    @

  startDrag: (e) ->
    @dragging     = true
    @dragOrigin   = x: e.clientX
                  , y: e.clientY
    @targetOrigin = x: @target.left
                  , y: @target.top
    $(@target.elem).addClass "dragging"
    false

  stopDrag: ->
    return unless @dragging
    @dragging = false
    $(@target.elem).removeClass "dragging"

  drag: (e) ->
    return true unless @dragging

    snX = @snapX * @zoom.v
    snY = @snapY * @zoom.v
    dx = (Math.round((e.clientX - @dragOrigin.x) / snX) * snX) / @zoom.v
    dy = (Math.round((e.clientY - @dragOrigin.y) / snY) * snY) / @zoom.v
    x  = @targetOrigin.x + dx
    y  = @targetOrigin.y + dy

    @target.left = x unless @lockX
    @target.top  = y unless @lockY

