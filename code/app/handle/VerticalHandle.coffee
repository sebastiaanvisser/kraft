Module "handle.VerticalHandle"

Import "handle.Handle"
Import "visible.VisibleRect"

Class

  VerticalHandle: ->
    @defHandlePoint "handleV", VisibleRect, 0, 0, 2, 16
    @handle.dragger.lockX   = true
    @handleV.dragger.lockX  = true
    @handleV.background.hex = "rgba(0,0,0, 0.8)"

Static make: (args...) -> (Handle.make args...).decorate VerticalHandle

