Module "visible.Line"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  Line: (w) ->
    $(@elem).addClass "line"
    @define width: w

  render: ->
    len = Math.sqrt (Math.pow @p1.x - @p0.x, 2) + (Math.pow @p1.y - @p0.y, 2)
    rot = (Math.atan (@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI

    st = @elem.style
    st.left   = px (@p0.x + @p1.x - len)    / 2
    st.top    = px (@p0.y + @p1.y - @width) / 2
    st.width  = px len
    st.height = px @width

    st["-webkit-transform"] = "rotate(" + rot + "deg)"

