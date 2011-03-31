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
    C.eq @$.x, @guide.p0.$.x
    C.eq @$.x, @guide.p1.$.x
    # C.eq @guide.p1.$.y, @context.canvas.$.width

#    @define caption: mk Line, @x, 0, @x, 100
#    @caption.decorate Text, ""
#    @caption.decorate VisibleShape, @context
#    @caption.decorate VisibleText
#    @caption.decorate MoveableShape
#    @caption.dragger.lockY = true
#    $(@caption.elem).addClass "guide-caption"
#
#    C.eq   @$.x, @caption.p0.$.x
#    C.eq   @$.x, @caption.p1.$.x
#    C.eq   @caption.$.text, @$.x
#    C.eq   @caption.p0.$.y, @context.canvas.viewport.p0.$.y
#    C.add0 @caption.p1.$.y, @context.canvas.viewport.p0.$.y, 50

