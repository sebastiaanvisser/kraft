Module "shape.AdjustableText"

Import "base.Obj"
Import "shape.Handle"

Class

  AdjustableText: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define "topLeft",     (Handle.make @model, @p0)
    @handles.define "bottomRight", (Handle.make @model, @p1)
    @handles.define "center",      (Handle.make @model, @center)

  delHandles: -> @handles.destructor()

Static

  init: -> Obj.register AdjustableText

