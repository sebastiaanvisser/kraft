Module "visible.Document"

Import "base.Obj"
Import "Units"

Register "Obj"
Class

  Document: () ->
    $(@elem).addClass "document"
    @topLeft.onchange (_, p) =>
      $(@renderContext.canvas.gridElem).css "-webkit-mask-position", (px p.x) + ' ' + (px p.y)
    @

  render: ->
    st = @elem.style

    st.left   = px @left
    st.top    = px @top
    st.width  = px @right  - @left
    st.height = px @bottom - @top

