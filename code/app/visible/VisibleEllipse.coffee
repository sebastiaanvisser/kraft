Module "visible.VisibleEllipse"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  VisibleEllipse: (canvas, renderer, parentElem) ->
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
    ($ elem).addClass "ellipse"
    @parentElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    st = @elem.style

    st.left   = px @left
    st.top    = px @top
    st.width  = px @width
    st.height = px @height

    st.borderTopLeftRadius     =
    st.borderTopRightRadius    =
    st.borderBottomLeftRadius  =
    st.borderBottomRightRadius = (px @width / 2) + ' ' + (px @height / 2)

  unrender: -> @parentElem.removeChild @elem

