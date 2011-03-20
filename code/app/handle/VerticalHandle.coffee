Module "handle.VerticalHandle"

Import "handle.Handle"
Import "visible.VisibleRect"

Class

  VerticalHandle: ->
    @defHandlePoint "handleV", VisibleRect, 0, 0, 2, 16
    @handle.dragger.lockX  = true
    @handleV.dragger.lockX = true

Static make: (args...) -> (Handle.make args...).decorate VerticalHandle

