Module "handle.VerticalHandle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Qualified "constraint.Point", As "Pt"
Qualified "visible.Rect",     As "VisibleRect"
Qualified "visible.Shape",    As "VisibleShape"

Register "Obj"
Class

  VerticalHandle: ->

    @define handleV: mk Rect, 0, 0, 2, 16
    @handleV.decorate VisibleShape, @context
    @handleV.decorate VisibleRect
    @handleV.decorate MoveableShape
    $(@handleV.elem).addClass "handleV"
    Pt.eq @handleV.center, @pt

    @handle.dragger.lockX  = true
    @handleV.dragger.lockX = true
    @handleV.background.rgba = "rgba(0,0,0, 0.4)"

    @

