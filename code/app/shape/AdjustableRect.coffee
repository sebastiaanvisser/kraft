Module "shape.AdjustableRect"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "shape.Handle"
Import "shape.HorizontalHandle"
Import "shape.VerticalHandle"
Qualified "shape.Point", "Pt"

Class

  AdjustableRect: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @define "handles", new Obj("Handles", @)
    @handles.define "topLeft",     (Handle.make           @model, @p0)
    @handles.define "topRight",    (Handle.make           @model, @p1)
    @handles.define "bottomLeft",  (Handle.make           @model, @p2)
    @handles.define "bottomRight", (Handle.make           @model, @p3)
    @handles.define "midLeft",     (HorizontalHandle.make @model, @midLeft)
    @handles.define "midRight",    (HorizontalHandle.make @model, @midRight)
    @handles.define "midTop",      (VerticalHandle.make   @model, @midTop)
    @handles.define "midBottom",   (VerticalHandle.make   @model, @midBottom)
    @handles.define "center",      (Handle.make           @model, @center)

    radiusH = Pt.make()
    add0 radiusH.$.y, @topLeft.$.y, val 10
    add0 radiusH.$.x, @$.radius, @topLeft.$.x
    @handles.define "radiusH", (HorizontalHandle.make @model, radiusH)

    borderH = Pt.make()
    add0 borderH.$.x, @$.border, @topLeft.$.x
    add0 borderH.$.y, @midLeft.$.y, val 10
    @handles.define "borderH", (HorizontalHandle.make @model, borderH)

  delHandles: ->
    @handles.destructor()

Static

  init: ->
    Obj.register AdjustableRect

