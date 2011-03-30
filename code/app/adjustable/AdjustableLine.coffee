Module "adjustable.AdjustableLine"

Import "handle.Handle"
Import "adjustable.SelectableShape"
Import "base.Obj"

Register "Obj"
Class

  AdjustableLine: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define
      topLeft:     mk Handle, @p0,     @renderContext
      bottomRight: mk Handle, @p1,     @renderContext
      center:      mk Handle, @center, @renderContext

  delHandles: ->
    @handles.destructor()
    delete @handles

