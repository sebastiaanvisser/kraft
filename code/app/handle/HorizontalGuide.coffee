Module "handle.HorizontalGuide"

Import "base.Obj"
Import "base.Value"
Import "shape.Line"
Import "shape.Point"
Import "shape.Text"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Qualified "constraint.Constraint", As "C"
Qualified "visible.Line",  As "VisibleLine"
Qualified "visible.Text",  As "VisibleText"
Qualified "visible.Shape", As "VisibleShape"

Register "Obj"
Class

  HorizontalGuide: (context, y) ->
    @context = context
    @define y: y
    @setupGuide()
    @

  setupGuide: ->
    @define guide: mk Line, 0, @y, 1000, @y
    @guide.decorate VisibleShape, @context
    @guide.decorate VisibleLine, 2
    @guide.decorate MoveableShape
    @guide.decorate SelectableShape, @context.selection
    @guide.dragger.lockX = true
    $(@guide.elem).addClass "guide"
    C.eq @$.y, @guide.$.top
    C.eq @guide.p1.$.x, @context.canvas.$.height

    @define caption: mk Line, 100, 100, 200, 100
    @caption.decorate Text, ""
    @caption.decorate VisibleShape, @context
    @caption.decorate VisibleText
    @caption.decorate MoveableShape
    @caption.dragger.lockX = true
    $(@caption.elem).addClass "guide-caption"

    C.eq @$.y, @caption.$.top
    C.eq @caption.$.text, @$.y
    C.eq @caption.$.left, @context.canvas.viewport.p0.$.x

