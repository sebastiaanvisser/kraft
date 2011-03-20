Module "handle.Handle"

Import "base.Obj"
Import "shape.Rect"
Import "adjustable.MoveableShape"
Import "visible.VisibleEllipse"
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
    @[prop].decorate MoveableShape
    $(@[prop].elem).addClass prop

Static

  init: -> Obj.register Handle

  make: (args...) -> (new Obj "Handle").decorate Handle, args...

