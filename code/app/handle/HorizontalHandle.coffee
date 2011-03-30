Module "handle.HorizontalHandle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Import "visible.VisibleRect"
Import "visible.VisibleShape"
Qualified "constraint.Point", "Pt"

Register "Obj"
Class

  HorizontalHandle: () ->

    @define handleH: mk Rect, 0, 0, 16, 2
    @handleH.decorate VisibleShape, @renderContext
    @handleH.decorate VisibleRect
    @handleH.decorate MoveableShape
    $(@handleH.elem).addClass "handleH"
    Pt.eq @handleH.center, @pt

    @handle.dragger.lockY  = true
    @handleH.dragger.lockY = true
    @handleH.background.rgba = "rgba(0,0,0, 0.4)"

    @

