Module "adjustable.Document"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "handle.Handle"

Register "Obj"
Class

  Document: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @derive handles: new Obj
    @handles.define
      topLeft:     mk Handle, @context, @p0
      bottomRight: mk Handle, @context, @p3

  delHandles: ->
    @handles.destructor()
    delete @handles

