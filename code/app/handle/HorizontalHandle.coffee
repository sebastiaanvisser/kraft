Module "handle.HorizontalHandle"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "shape.Rect"
Qualified "constraint.Point", As "Pt"
Qualified "visible.Rect",     As "VisibleRect"
Qualified "visible.Shape",    As "VisibleShape"

Register "Obj"
Class

  HorizontalHandle: ->

    @define handleH: mk Rect, 0, 0, 16, 2
    @handleH.decorate VisibleShape, @context
    @handleH.decorate VisibleRect
    @handleH.decorate MoveableShape
    $(@handleH.elem).addClass "handleH"
    Pt.eq @handleH.center, @pt

    @handle.dragger.lockY  = true
    @handleH.dragger.lockY = true
    @handleH.background.rgba = "rgba(0,0,0, 0.4)"

    @

