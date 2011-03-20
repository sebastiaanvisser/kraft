Module "adjustable.AdjustableLine"

Import "handle.Handle"
Import "adjustable.SelectableShape"
Import "base.Obj"

Class

  AdjustableLine: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define "topLeft",     Handle.make(@parent, @p0)
    @handles.define "bottomRight", Handle.make(@parent, @p1)
    @handles.define "center",      Handle.make(@parent, @center)

  delHandles: -> @handles.destructor()

Static init: -> Obj.register AdjustableLine

