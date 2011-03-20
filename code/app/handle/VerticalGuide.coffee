Module "handle.VerticalGuide"

Import "base.Obj"
Import "shape.Line"
Import "shape.Point"
Import "shape.Text"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Import "visible.VisibleLine"
Import "visible.VisibleText"
Qualified "constraint.Constraint", "C"

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

Static

  init: -> Obj.register VerticalGuide

  make: (args...) -> (new Obj "VerticalGuide").decorate VerticalGuide, args...

