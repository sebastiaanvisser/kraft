Module "visible.VisibleDocument"

Import "base.Obj"
Import "Units"

Class

  VisibleDocument: (canvas, renderer, elem) ->
    @canvas     = canvas
    @renderer   = renderer
    @parentElem = elem
    @elem       = @setupElem()

    @topLeft.onchange (_, p) =>
      ($ @canvas.gridElem).css "-webkit-mask-position", (px p.x) + ' ' + (px p.y)

    # Setup rendering and perform initial render.
    @onchange -> @renderer.enqueue @
    @renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "document"
    @parentElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    @elem.style.left   = px @left
    @elem.style.top    = px @top
    @elem.style.width  = px @right  - @left
    @elem.style.height = px @bottom - @top

  unrender: -> @parentElem.removeChild @elem

Static

  init: -> Obj.register VisibleDocument

