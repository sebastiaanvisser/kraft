Module "adjustable.AdjustableTriangle"

Import "base.Obj"
Import "handle.Handle"
Import "handle.VerticalHandle"
Import "handle.HorizontalHandle"

Register "Obj"
Class

  AdjustableTriangle: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define "topLeft",     (Handle.make           @model, @p0)
    @handles.define "topRight",    (Handle.make           @model, @p1)
    @handles.define "bottomLeft",  (Handle.make           @model, @p2)
    @handles.define "bottomRight", (Handle.make           @model, @p3)
    @handles.define "midLeft",     (HorizontalHandle.make @model, @midLeft)
    @handles.define "midRight",    (HorizontalHandle.make @model, @midRight)
    @handles.define "midTop",      (VerticalHandle.make   @model, @midTop)
    @handles.define "midBottom",   (VerticalHandle.make   @model, @midBottom)
    @handles.define "center",      (Handle.make           @model, @center)

  delHandles: ->
    @handles.destructor()
    delete @handles

