Module "shape.VisibleEllipse"

Import "base.Obj"
Import "Units"

Class

  VisibleEllipse: (revive) ->
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

Static init: -> Obj.register VisibleEllipse

