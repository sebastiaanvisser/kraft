Module "handle.VerticalGuide"

Import "base.Obj"
Import "base.Value"
Import "shape.Line"
Import "shape.Point"
Import "shape.Text"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Qualified "constraint.Constraint", As "C"
Qualified "visible.Line",          As "VisibleLine"
Qualified "visible.Text",          As "VisibleText"

Register "Obj"
Class

  VerticalGuide: (revive, parent, x) ->
    @parent = parent
    @canvas = parent.canvas
    @define "x", x

    @setupGuide()
    @

  setupGuide: ->

    @define "guide", Line.make @parent, (Point.make @parent, @x, 0), (Point.make @parent, @x, 0), 2
    @guide.decorate VisibleLine
    @guide.decorate MoveableShape
    @guide.decorate SelectableShape
    @guide.dragger.lockY = true
    ($ @guide.elem).addClass "guide"
    C.eq @$.x, @guide.p0.$.x
    C.eq @$.x, @guide.p1.$.x
    C.eq @guide.p1.$.y, @canvas.$.height

    @define "caption", Text.make @parent, @x, 0, @x, 100, ""
    @caption.decorate VisibleText
    @caption.decorate MoveableShape
    @caption.dragger.lockY = true
    $(@caption.elem).addClass "guide-caption"
    $(@caption.elem).addClass "shape"

    C.eq @$.x, @caption.p0.$.x
    C.eq @$.x, @caption.p1.$.x
    C.eq @caption.$.text, @$.x
    C.eq   @caption.p0.$.y, @canvas.viewport.p0.$.y
    C.add0 @caption.p1.$.y, @canvas.viewport.p0.$.y, val 50

