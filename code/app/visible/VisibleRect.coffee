Module "visible.VisibleRect"

Import "base.Obj"
Import "Units"
Import "style.Color"

Register "Obj"
Class

  VisibleRect: (canvas, renderer, parentElem) ->
    @canvas     = canvas
    @renderer   = renderer
    @parentElem = parentElem
    @elem       = @setupElem()

    @define background: mk Color, "#ffbb00"

    # Setup rendering and perform initial render.
    @onchange -> @renderer.enqueue @
    @renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    ($ elem).addClass "rect"
    @parentElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    st = @elem.style

    st.left   = px @left
    st.top    = px @top
    st.width  = px @width
    st.height = px @height

    st.backgroundColor = @background.rgba

    st.borderTopLeftRadius     =
    st.borderTopRightRadius    =
    st.borderBottomLeftRadius  =
    st.borderBottomRightRadius =
      px if @radius >= 0 then @radius else Math.round -@radius / 5

    st.borderWidth =
      px if @border >= 0 then @border else Math.round -@border / 5

  unrender: -> @parentElem.removeChild @elem

