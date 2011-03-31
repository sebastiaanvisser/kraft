Module "handle.Handle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Qualified "constraint.Point", As "Pt"
Qualified "visible.Ellipse",  As "VisibleEllipse"
Qualified "visible.Shape",    As "VisibleShape"

Register "Obj"
Class

  Handle: (pt, renderContext) ->
    @pt = pt
    @renderContext = renderContext
    @define handle: mk Rect, 0, 0, 10, 10
    @handle.decorate VisibleShape, renderContext
    @handle.decorate VisibleEllipse
    @handle.decorate MoveableShape
    $(@handle.elem).addClass "handle"
    Pt.eq @handle.center, @pt
    @

