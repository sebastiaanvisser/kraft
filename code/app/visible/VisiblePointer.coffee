Module "visible.VisiblePointer"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  VisiblePointer: () ->
    $(@elem).addClass "pointer"
    @

  render: ->
    len = Math.sqrt (Math.pow @p1.x - @p0.x, 2) + (Math.pow @p1.y - @p0.y, 2)
    rot = (Math.atan (@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI + 45

    w = len * Math.cos Math.PI/4
    h = len * Math.cos Math.PI/4

    st = @elem.style
    st.width  = px w
    st.height = px h
    st.left   = px (@p0.x + @p1.x - w) / 2
    st.top    = px (@p0.y + @p1.y - h) / 2
    st["-webkit-transform"] = "rotate(" + rot + "deg)"

