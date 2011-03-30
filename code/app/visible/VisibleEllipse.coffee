Module "visible.VisibleEllipse"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  VisibleEllipse: ->
    $(@elem).addClass "ellipse"

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

