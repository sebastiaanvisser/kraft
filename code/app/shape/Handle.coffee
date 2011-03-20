Module "shape.Handle"

Import "base.Obj"
Import "shape.DraggableShape"
Import "shape.Rect"
Import "shape.VisibleEllipse"
Qualified "constraint.Point", "P"

Class

  Handle: (revive, parent, pt) ->
    @parent = parent
    @pt     = pt
    @defHandlePoint "handle", VisibleEllipse, 0, 0, 10, 10
    @

  defHandlePoint: (prop, type, x, y, w, h) ->
    @define prop, Rect.make @parent, x, y, w, h
    P.eq @[prop].center, @pt
    @[prop].decorate type
    @[prop].decorate DraggableShape
    $(@[prop].elem).addClass prop

Static

  init: -> Obj.register Handle

  make: (args...) -> (new Obj "Handle").decorate Handle, args...

Module "shape.VerticalHandle"

Import "shape.Handle"
Import "shape.VisibleRect"

Class

  VerticalHandle: ->
    @defHandlePoint "handleV", VisibleRect, 0, 0, 2, 16
    @handle.dragger.lockX  = true
    @handleV.dragger.lockX = true

Static make: (args...) -> (Handle.make args...).decorate VerticalHandle

Module "shape.HorizontalHandle"

Import "shape.Handle"
Import "shape.VisibleRect"

Class

  HorizontalHandle: ->
    @defHandlePoint "handleH", VisibleRect, 0, 0, 16, 2
    @handle.dragger.lockY  = true
    @handleH.dragger.lockY = true

Static make: (args...) -> (Handle.make args...).decorate HorizontalHandle

