Module "visible.Text"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  Text: () ->
    $(@elem).addClass "text"
    @

  render: ->
    @elem.innerHTML = @text unless @elem.innerHTML == @text
    w = @elem.offsetWidth
    h = @elem.offsetHeight

    len = Math.sqrt (Math.pow @p1.x - @p0.x, 2) + (Math.pow @p1.y - @p0.y, 2)
    rot = (Math.atan (@p1.y - @p0.y) / (@p1.x - @p0.x)) * 180 / Math.PI

    st = @elem.style
    st.left = px (@p0.x + @p1.x - w) / 2
    st.top  = px (@p0.y + @p1.y - h) / 2
    st["-webkit-transform"] = "rotate(" + rot + "deg)"

