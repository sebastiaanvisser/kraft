Module "adjustable.Line"

Import "handle.Handle"
Import "adjustable.SelectableShape"
Import "base.Obj"

Register "Obj"
Class

  Line: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define
      topLeft:     mk Handle, @context, @p0
      bottomRight: mk Handle, @context, @p1
      center:      mk Handle, @context, @center

  delHandles: ->
    @handles.destructor()
    delete @handles

