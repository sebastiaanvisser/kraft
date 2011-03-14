Module "shape.RenderableDocument"

Import "base.Obj"

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
    w = @right  - @left
    h = @bottom - @top

    @elem.style.left   = @left + "px"
    @elem.style.top    = @top  + "px"
    @elem.style.width  = w     + "px"
    @elem.style.height = h     + "px"

  unrender: ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: -> Obj.register RenderableDocument

