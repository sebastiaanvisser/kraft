Module "handle.Handle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Import "visible.VisibleEllipse"
Qualified "constraint.Point", "Pt"

Register "Obj"
Class

  Handle: (pt, canvas, renderer, elem) ->
    @define pt: pt

    @define handle: mk Rect, 0, 0, 10, 10
    @handle.decorate VisibleEllipse, canvas, renderer, elem
    @handle.decorate MoveableShape
    ($ @handle.elem).addClass "handle"
    Pt.eq @handle.center, @pt
    @

