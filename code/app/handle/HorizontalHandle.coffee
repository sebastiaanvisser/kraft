Module "handle.HorizontalHandle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Import "visible.VisibleRect"
Qualified "constraint.Point", "Pt"

Register "Obj"
Class

  HorizontalHandle: (canvas, renderer, elem) ->

    @define handleH: mk Rect, 0, 0, 16, 2
    @handleH.decorate VisibleRect, canvas, renderer, elem
    @handleH.decorate MoveableShape
    ($ @handleH.elem).addClass "handleH"
    Pt.eq @handleH.center, @pt

    @handle.dragger.lockY  = true
    @handleH.dragger.lockY = true
    @handleH.background.rgba = "rgba(0,0,0, 0.4)"

    @

