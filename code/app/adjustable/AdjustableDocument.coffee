Module "adjustable.AdjustableDocument"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "handle.Handle"

Register "Obj"
Class

  AdjustableDocument: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @derive handles: new Obj
    @handles.define
      topLeft:     mk Handle, @p0, @renderContext
      bottomRight: mk Handle, @p3, @renderContext

  delHandles: ->
    @handles.destructor()
    delete @handles

