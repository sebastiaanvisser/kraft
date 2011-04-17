Module "handle.VerticalGuide"

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

  VerticalGuide: (context, x) ->
    @context = context
    @define x: x
    @setupGuide()
    @

  setupGuide: ->
    @define guide: mk Line, @x, 0, @x, 1000
    @guide.decorate VisibleShape, @context
    @guide.decorate VisibleLine, 2
    @guide.decorate MoveableShape
    @guide.decorate SelectableShape, @context.selection
    @guide.dragger.lockY = true
    $(@guide.elem).addClass "guide"
    C.eq @$.x, @guide.$.left
    C.eq @guide.p1.$.y, @context.canvas.$.width

    @define caption: mk Line, 100, 100, 100, 200
    @caption.decorate Text, ""
    @caption.decorate VisibleShape, @context
    @caption.decorate VisibleText
    @caption.decorate MoveableShape
    @caption.dragger.lockY = true
    $(@caption.elem).addClass "guide-caption"

    C.eq @$.x, @caption.$.left
    C.eq @caption.$.text, @$.x
    C.eq @caption.$.top, @context.canvas.viewport.$.top

