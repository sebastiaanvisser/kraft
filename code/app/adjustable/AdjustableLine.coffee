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
      topLeft:     mk Handle, @p0,     @canvas, @renderer, @parentElem
      bottomRight: mk Handle, @p1,     @canvas, @renderer, @parentElem
      center:      mk Handle, @center, @canvas, @renderer, @parentElem

  delHandles: -> @handles.destructor()

