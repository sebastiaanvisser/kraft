Module "visible.VisibleLine"

Import "base.Obj"
Import "shape.Line"
Import "Units"

Register "Obj"
Class

  VisibleLine: (canvas, renderer, parentElem, w) ->
    @canvas     = canvas
    @renderer   = renderer
    @parentElem = parentElem
    @elem       = @setupElem()

    @define width: w

    # Setup rendering and perform initial render.
    @onchange -> @renderer.enqueue @
    @renderer.enqueue @
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "line"
    @parentElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    len = Math.sqrt (Math.pow @p1.x - @p0.x, 2) + (Math.pow @p1.y - @p0.y, 2)
    rot = (Math.atan (@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI

    st = @elem.style
    st.left   = px (@p0.x + @p1.x - len)    / 2
    st.top    = px (@p0.y + @p1.y - @width) / 2
    st.width  = px len
    st.height = px @width

    st["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: -> @parentElem.removeChild @elem

