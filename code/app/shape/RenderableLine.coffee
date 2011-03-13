Module "shape.RenderableLine"

Import "base.Obj"
Import "shape.Line"

Class

  RenderableLine: (revive, model) ->
    @model  = model
    @canvas = @model.canvas
    @elem   = @setupElem()

    @onchange => @canvas.renderer.enqueue @
    @render()
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "line"
    elem.style.position = "absolute"
    @canvas.canvasElem.appendChild elem
    elem

  destructor: ->
    @unrender()

  render: ->
    x0 = @p0.x
    y0 = @p0.y
    x1 = @p1.x
    y1 = @p1.y
    w  = @width
    len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI
    @elem.style.left   = ((x0 + x1 - len) / 2) + "px"
    @elem.style.top    = ((y0 + y1 - w)   / 2) + "px"
    @elem.style.width  = len                   + "px"
    @elem.style.height = w                     + "px"

    @elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: ->
    @canvas.canvasElem.removeChild @elem

Static

  init: ->
    Obj.register RenderableLine

  make: (canvas, x0, y0, x1, y1, w) ->
    (Line.make x0, y0, x1, y1, w).decorate RenderableLine, canvas

