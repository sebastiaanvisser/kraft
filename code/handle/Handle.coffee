Module "handle.Handle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Qualified "constraint.Point", As "Pt"
Qualified "visible.Ellipse",  As "VisibleEllipse"
Qualified "visible.Shape",    As "VisibleShape"

Register "Obj"
Class

  Handle: (context, pt) ->
    @pt = pt
    @context = context
    @define handle: mk Rect, 0, 0, 10, 10
    @handle.decorate VisibleShape, @context
    @handle.decorate VisibleEllipse
    @handle.decorate MoveableShape
    $(@handle.elem).addClass "handle"
    Pt.eq @handle.center, @pt
    @

