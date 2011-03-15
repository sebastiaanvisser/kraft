Module "shape.RenderableEllipse"

Import "base.Obj"
Import "Units"

Class

  RenderableEllipse: (revive, model) ->
    @model = model
    @elem  = @setupElem()

    @onchange => @model.canvas.renderer.enqueue @
    @render()
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "ellipse"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    style = @elem.style

    style.left   = px @left
    style.top    = px @top
    style.width  = px @width
    style.height = px @height

    style.borderTopLeftRadius     =
    style.borderTopRightRadius    =
    style.borderBottomLeftRadius  =
    style.borderBottomRightRadius = (px @width / 2) + ' ' + (px @height / 2)

  unrender: ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: -> Obj.register RenderableEllipse

