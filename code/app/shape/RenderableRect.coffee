Module "shape.RenderableRect"

Import "base.Obj"
Import "Units"

Class

  RenderableRect: (revive, model) ->
    @model    = model
    @elem     = @setupElem()

    @onchange -> @model.canvas.renderer.enqueue @
    @model.canvas.renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "rect"
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
    style.borderBottomRightRadius =
      px if @radius >= 0 then @radius else Math.round -@radius / 5

    style.borderWidth =
      px if @border >= 0 then @border else Math.round -@border / 5

  unrender: -> @model.canvas.canvasElem.removeChild @elem

Static init: -> Obj.register RenderableRect

