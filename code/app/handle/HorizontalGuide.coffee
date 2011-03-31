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
    C.eq @$.y, @guide.p0.$.y
    # C.eq @$.y, @guide.p1.$.y
    C.eq @guide.p1.$.x, @context.canvas.$.width

    @define caption: mk Line, 0, @y, 100, @y
    @caption.decorate Text, ""
    @caption.decorate VisibleShape, @context
    @caption.decorate VisibleText
    @caption.decorate MoveableShape
    @caption.dragger.lockX = true
    $(@caption.elem).addClass "guide-caption"

    C.eq   @$.y, @caption.p0.$.y
    C.eq   @$.y, @caption.p1.$.y
    C.eq   @caption.$.text, @$.y
    C.eq   @caption.p0.$.x, @context.canvas.viewport.p0.$.x
    C.add0 @caption.p1.$.x, @context.canvas.viewport.p0.$.x, 50

