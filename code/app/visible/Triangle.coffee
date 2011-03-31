Module "visible.Triangle"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  Triangle: (revive, model) ->
    @model = model
    @setupElem()

    @onchange => @model.canvas.renderer.enqueue @
    @model.canvas.renderer.enqueue @

  setupElem: ->
    @elem = document.createElement "div"
    ($ @elem).addClass "triangle"
    @model.canvas.canvasElem.appendChild @elem

    @elem1 = document.createElement "div"
    ($ @elem1).addClass "inner-triangle"
    @elem.appendChild @elem1

  destructor: -> @unrender()

  render: ->
    st = @elem.style
    st.left   = px @left
    st.top    = px @top
    st.width  = px @width
    st.height = px @height

    len = Math.sqrt (Math.pow @p3.x - @p0.x, 2) + (Math.pow @p3.y - @p0.y, 2)
    rot = (Math.atan (@p3.y - @p0.y) / (@p3.x - @p0.x)) * 180 / Math.PI

    st = @elem1.style
    st.left   = px (@p3.x > @p0.x ? 1 : -1) * (@center.x - @left)
    st.top    = px 0
    st.width  = px @width
    st.height = px @height

    st["-webkit-transform"] = "skew(" + (90 + rot) + "deg)"

  unrender: -> @model.canvas.canvasElem.removeChild @elem

