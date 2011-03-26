Module "handle.HorizontalHandle"

Import "handle.Handle"
Import "visible.VisibleRect"

Class

  HorizontalHandle: ->
    @defHandlePoint "handleH", VisibleRect, 0, 0, 16, 2
    @handle.dragger.lockY   = true
    @handleH.dragger.lockY  = true
    @handleH.background.hex = "rgba(0,0,0, 0.8)"

Static make: (args...) -> (Handle.make args...).decorate HorizontalHandle

