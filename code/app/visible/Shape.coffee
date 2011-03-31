Module "visible.Shape"

Import "base.Obj"

Register "Obj"
Class

  Shape: (renderContext) ->
    @renderContext = renderContext
    @setupElem()

    # Setup rendering and perform initial render.
    @onchange -> @renderContext.renderer.enqueue @
    @renderContext.renderer.enqueue @
    @

  setupElem: ->
    @elem = document.createElement "div"
    $(@elem).addClass "shape"
    @renderContext.elem.appendChild @elem

  destructor: -> @unrender()

  render: -> {}

  unrender: -> @renderContext.elem.removeChild @elem

