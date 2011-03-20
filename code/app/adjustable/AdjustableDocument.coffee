Module "adjustable.AdjustableDocument"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "handle.Handle"
Import "handle.HorizontalHandle"
Import "handle.VerticalHandle"
Qualified "shape.Point", "Pt"

Class

  AdjustableDocument: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @define "handles", new Obj("Handles", @)
    @handles.define "topLeft",     (Handle.make @parent, @p0)
    @handles.define "bottomRight", (Handle.make @parent, @p3)

  delHandles: ->
    @handles.destructor()

Static init: -> Obj.register AdjustableDocument

