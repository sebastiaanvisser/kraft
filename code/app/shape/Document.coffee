Module "shape.RenderableDocument"

Import "base.Obj"
Import "Units"

Class

  RenderableDocument: (revive, model) ->
    @model  = model
    @elem   = @setupElem()

    @onchange => @model.canvas.renderer.enqueue @
    @render()
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "document"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    @elem.style.left   = px @left
    @elem.style.top    = px @top
    @elem.style.width  = px @right  - @left
    @elem.style.height = px @bottom - @top

  unrender: ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: -> Obj.register RenderableDocument

