Module "shape.RenderableText"

Import "base.Obj"

Class

  RenderableText: (revive, model) ->
    @model = model
    @elem  = @setupElem()
    @elem.innerHTML = @text

    @onchange -> @model.canvas.renderer.enqueue @
    @model.canvas.renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "text"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    w = @elem.offsetWidth
    h = @elem.offsetHeight

    len = Math.sqrt(Math.pow(@p1.x - @p0.x, 2) + Math.pow(@p1.y - @p0.y, 2))
    rot = Math.atan((@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI

    @elem.style.left = ((@p0.x + @p1.x - w) / 2) + "px"
    @elem.style.top  = ((@p0.y + @p1.y - h) / 2) + "px"
    @elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: -> @model.canvas.canvasElem.removeChild @elem

Static init: -> Obj.register RenderableText

