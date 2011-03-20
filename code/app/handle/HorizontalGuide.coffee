Module "handle.HorizontalGuide"

Import "base.Obj"
Import "base.Value"
Import "shape.Line"
Import "shape.Point"
Import "shape.Text"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Import "visible.VisibleLine"
Import "visible.VisibleText"
Qualified "constraint.Constraint", "C"

Class

  HorizontalGuide: (revive, parent, y) ->
    @parent = parent
    @canvas = parent.canvas
    @define "y", y

    @setupGuide()
    @

  setupGuide: ->
    @define "guide", Line.make @parent, (Point.make @parent, 0, @y), (Point.make @parent, 1000, @y), 2
    @guide.decorate VisibleLine
    @guide.decorate MoveableShape
    @guide.decorate SelectableShape
    @guide.dragger.lockX = true
    ($ @guide.elem).addClass "guide"
    C.eq @$.y, @guide.p0.$.y
    C.eq @$.y, @guide.p1.$.y
    C.eq @guide.p1.$.x, @canvas.$.width

    @define "caption", Text.make @parent, 0, @y, 100, @y, ""
    @caption.decorate VisibleText
    @caption.decorate MoveableShape
    @caption.dragger.lockX = true
    $(@caption.elem).addClass "guide-caption"
    $(@caption.elem).addClass "shape"

    C.eq @$.y, @caption.p0.$.y
    C.eq @$.y, @caption.p1.$.y
    C.eq @caption.$.text, @$.y
    C.eq   @caption.p0.$.x, @canvas.viewport.p0.$.x
    C.add0 @caption.p1.$.x, @canvas.viewport.p0.$.x, val 50


Static

  init: -> Obj.register HorizontalGuide

  make: (args...) -> (new Obj "HorizontalGuide").decorate HorizontalGuide, args...

