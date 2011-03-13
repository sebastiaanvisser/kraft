Module "shape.Handle"

Import "base.Obj"
Import "shape.DraggableShape"
Import "shape.Rect"
Import "shape.RenderableEllipse"
Qualified "constraint.Point", "P"

Class

  Handle: (revive, model, pt) ->
    @model = model
    @pt    = pt
    @defHandlePoint "handle", RenderableEllipse, 0, 0, 10, 10
    @

  defHandlePoint: (prop, type, x, y, w, h) ->
    @define prop, Rect.make(x, y, w, h)
    window.xxx = true
    P.eq @[prop].center, @pt
    @[prop].decorate type, @model
    @[prop].decorate DraggableShape
    $(@[prop].elem).addClass prop

Static

  init: -> Obj.register Handle

  make: (model, pt) -> (new Obj "Handle").decorate Handle, model, pt

Module "shape.VerticalHandle"

Import "shape.Handle"
Import "shape.RenderableRect"

Class

  VerticalHandle: ->
    @defHandlePoint "handleV", RenderableRect, 0, 0, 2, 16
    @handle.dragger.lockX  = true
    @handleV.dragger.lockX = true

Static

  make: (model, pt) -> (Handle.make model, pt).decorate VerticalHandle

Module "shape.HorizontalHandle"

Import "shape.Handle"
Import "shape.RenderableRect"

Class

  HorizontalHandle: ->
    @defHandlePoint "handleH", RenderableRect, 0, 0, 16, 2
    @handle.dragger.lockY  = true
    @handleH.dragger.lockY = true

Static

  make: (model, pt) -> (Handle.make model, pt).decorate HorizontalHandle

