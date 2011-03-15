Module "shape.AdjustableDocument"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "shape.Handle"
Import "shape.HorizontalHandle"
Import "shape.VerticalHandle"
Qualified "shape.Point", "Pt"

Class

  AdjustableDocument: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @define "handles", new Obj("Handles", @)
    @handles.define "topLeft",     (Handle.make @model, @p0)
    @handles.define "bottomRight", (Handle.make @model, @p3)

  delHandles: ->
    @handles.destructor()

Static

  init: -> Obj.register AdjustableDocument

