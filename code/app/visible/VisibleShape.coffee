Module "visible.VisibleShape"

Import "base.Obj"

Register "Obj"
Class

  VisibleShape: (canvas, renderer, parentElem) ->
    @canvas     = canvas
    @renderer   = renderer
    @parentElem = parentElem
    @elem       = @setupElem()

    # Setup rendering and perform initial render.
    @onchange -> @renderer.enqueue @
    @renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "shape"
    @parentElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: -> {}

  unrender: -> @parentElem.removeChild @elem

