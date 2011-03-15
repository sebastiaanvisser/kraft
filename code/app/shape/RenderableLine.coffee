Module "shape.RenderableLine"

Import "base.Obj"
Import "shape.Line"
Import "Units"

Class

  RenderableLine: (revive, model) ->
    @model  = model
    @canvas = @model.canvas
    @elem   = @setupElem()

    @onchange => @canvas.renderer.enqueue @
    @canvas.renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "line"
    @canvas.canvasElem.appendChild elem
    elem

  destructor: ->
    @unrender()

  render: ->
    len = Math.sqrt (Math.pow @p1.x - @p0.x, 2) + (Math.pow @p1.y - @p0.y, 2)
    rot = (Math.atan (@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI

    @elem.style.left   = px (@p0.x + @p1.x - len)    / 2
    @elem.style.top    = px (@p0.y + @p1.y - @width) / 2
    @elem.style.width  = px len
    @elem.style.height = px @width

    @elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: -> @canvas.canvasElem.removeChild @elem

Static init: -> Obj.register RenderableLine

