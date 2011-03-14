Module "shape.RenderableText"

Import "base.Obj"
Qualified "Events", "E"

Class

  RenderableText: (revive, model) ->
    @model = model
    @elem  = @setupElem()
    @elem.innerHTML = @text

    @onchange -> @model.canvas.renderer.enqueue @
    @model.canvas.renderer.enqueue @
    @

    E.manager.bind @elem, "DOMCharacterDataModified",
      ((e) => console.log Math.random(), e; @model.canvas.renderer.enqueue @)

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "text"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    x0 = @p0.x
    y0 = @p0.y
    x1 = @p1.x
    y1 = @p1.y

    w = @elem.offsetWidth
    h = @elem.offsetHeight

    console.log Math.random(), "..."
    len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI

    @elem.style.left = ((x0 + x1 - w) / 2) + "px"
    @elem.style.top  = ((y0 + y1 - h) / 2) + "px"
    @elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: -> @model.canvas.canvasElem.removeChild @elem

Static init: -> Obj.register RenderableText

