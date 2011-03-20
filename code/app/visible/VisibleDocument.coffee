Module "visible.VisibleDocument"

Import "base.Obj"
Import "Units"

Class

  VisibleDocument: (revive) ->
    @parentElem = @parent.elem
    @canvas     = @parent.canvas
    @renderer   = @parent.renderer
    @elem       = @setupElem()

    # Setup rendering and perform initial render.
    @onchange -> @renderer.enqueue @
    @renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "document"
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

