Module "shape.RenderableRect"

Import "base.Obj"

Class

  RenderableRect: (revive, model) ->
    @model    = model
    @elem     = @setupElem()

    @onchange -> @model.canvas.renderer.enqueue @
    @render()
    @

  setupElem: () ->
    elem = document.createElement "div"
    $(elem).addClass "rect"
    elem.style.position = "absolute"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: () ->
    @unrender()

  render: () ->
    @elem.style.left   = @left   + "px"
    @elem.style.top    = @top    + "px"
    @elem.style.width  = @width  + "px"
    @elem.style.height = @height + "px"

    r = (if @radius >= 0 then @radius else Math.round(-@radius / 5)) + "px"
    @elem.style.borderTopLeftRadius     =
    @elem.style.borderTopRightRadius    =
    @elem.style.borderBottomLeftRadius  =
    @elem.style.borderBottomRightRadius = r

    b = (if @border >= 0 then @border else Math.round(-@border / 5)) + "px"
    @elem.style.borderWidth = b

  unrender: () ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: () -> Obj.register RenderableRect

