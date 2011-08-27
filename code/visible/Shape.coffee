Module "visible.Shape"

Import "base.Obj"

Register "Obj"
Class

  Shape: (context) ->
    @context = context
    @setupElem()

    # Setup rendering and perform initial render.
    @onchange -> @context.renderer.enqueue @
    @context.renderer.enqueue @
    @

  setupElem: ->
    @elem = document.createElement "div"
    $(@elem).addClass "shape"
    @context.elem.appendChild @elem

  destructor: -> @unrender()

  render: -> {}

  unrender: -> @context.elem.removeChild @elem

