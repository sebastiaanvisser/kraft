Module "shape.VisibleRect"

Import "base.Obj"
Import "Units"

Class

  VisibleRect: (revive) ->
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

    st.borderTopLeftRadius     =
    st.borderTopRightRadius    =
    st.borderBottomLeftRadius  =
    st.borderBottomRightRadius =
      px if @radius >= 0 then @radius else Math.round -@radius / 5

    st.borderWidth =
      px if @border >= 0 then @border else Math.round -@border / 5

  unrender: -> @parentElem.removeChild @elem

Static init: -> Obj.register VisibleRect

