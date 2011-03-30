Module "handle.VerticalHandle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Import "visible.VisibleRect"
Import "visible.VisibleShape"
Qualified "constraint.Point", "Pt"

Register "Obj"
Class

  VerticalHandle: () ->

    @define handleV: mk Rect, 0, 0, 2, 16
    @handleV.decorate VisibleShape, @renderContext
    @handleV.decorate VisibleRect
    @handleV.decorate MoveableShape
    $(@handleV.elem).addClass "handleV"
    Pt.eq @handleV.center, @pt

    @handle.dragger.lockX  = true
    @handleV.dragger.lockX = true
    @handleV.background.rgba = "rgba(0,0,0, 0.4)"

    @

