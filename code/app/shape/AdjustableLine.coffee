Module "shape.AdjustableLine"

Import "shape.Handle"
Import "shape.SelectableShape"
Import "shape.RenderableLine"
Import "base.Obj"

Class

  AdjustableLine: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define "topLeft",     Handle.make(@model, @p0)
    @handles.define "bottomRight", Handle.make(@model, @p1)
    @handles.define "center",      Handle.make(@model, @center)

  delHandles: -> @handles.destructor()

Static init: -> Obj.register AdjustableLine

