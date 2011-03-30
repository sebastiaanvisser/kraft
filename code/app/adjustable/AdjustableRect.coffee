Module "adjustable.AdjustableRect"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "handle.Handle"
Import "handle.HorizontalHandle"
Import "handle.VerticalHandle"
Qualified "shape.Point", "Pt"

Register "Obj"
Class

  AdjustableRect: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @derive handles: new Obj
    @handles.define
      topLeft:     mk Handle, @p0,        @renderContext
      topRight:    mk Handle, @p1,        @renderContext
      bottomLeft:  mk Handle, @p2,        @renderContext
      bottomRight: mk Handle, @p3,        @renderContext
      midLeft:     mk Handle, @midLeft,   @renderContext
      midRight:    mk Handle, @midRight,  @renderContext
      midTop:      mk Handle, @midTop,    @renderContext
      midBottom:   mk Handle, @midBottom, @renderContext
      center:      mk Handle, @center,    @renderContext

    @handles.midLeft.decorate   HorizontalHandle, @renderContext
    @handles.midRight.decorate  HorizontalHandle, @renderContext
    @handles.midTop.decorate    VerticalHandle,   @renderContext
    @handles.midBottom.decorate VerticalHandle,   @renderContext

    radiusH = mk Pt, 0, 0
    window.radiusH = radiusH
    add0 radiusH.$.y, @topLeft.$.y, val 10
    add0 radiusH.$.x, @$.radius, @topLeft.$.x
    @handles.define radiusH: mk Handle, radiusH, @renderContext
    @handles.radiusH.decorate HorizontalHandle, @renderContext

    borderH = mk Pt
    add0 borderH.$.x, @$.border, @topLeft.$.x
    add0 borderH.$.y, @midLeft.$.y, val 10
    @handles.define borderH: mk Handle, borderH, @renderContext
    @handles.borderH.decorate HorizontalHandle, @renderContext

  delHandles: ->
    @handles.destructor()
    delete @handles

