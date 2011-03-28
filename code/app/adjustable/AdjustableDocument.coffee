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
      topLeft:     mk Handle, @p0, @canvas, @renderer, @parentElem
      bottomRight: mk Handle, @p3, @canvas, @renderer, @parentElem
      xx:          mk Handle, @p1, @canvas, @renderer, @parentElem
      yy:          mk Handle, @p2, @canvas, @renderer, @parentElem

  delHandles: -> @handles.destructor()

