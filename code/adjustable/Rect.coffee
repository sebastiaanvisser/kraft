Module "adjustable.Rect"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "handle.Handle"
Import "handle.HorizontalHandle"
Import "handle.VerticalHandle"
Qualified "shape.Point", As "Pt"

Register "Obj"
Class

  Rect: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @derive handles: new Obj
    @handles.define
      topLeft:     mk Handle, @context, @p0
      topRight:    mk Handle, @context, @p1
      bottomLeft:  mk Handle, @context, @p2
      bottomRight: mk Handle, @context, @p3
      midLeft:     mk Handle, @context, @midLeft
      midRight:    mk Handle, @context, @midRight
      midTop:      mk Handle, @context, @midTop
      midBottom:   mk Handle, @context, @midBottom
      center:      mk Handle, @context, @center

    @handles.midLeft.decorate   HorizontalHandle, @context
    @handles.midRight.decorate  HorizontalHandle, @context
    @handles.midTop.decorate    VerticalHandle,   @context
    @handles.midBottom.decorate VerticalHandle,   @context

    radiusH = mk Pt, 0, 0
    window.radiusH = radiusH
    add0 radiusH.$.y, @topLeft.$.y, val 10
    add0 radiusH.$.x, @$.radius, @topLeft.$.x
    @handles.define radiusH: mk Handle, @context, radiusH
    @handles.radiusH.decorate HorizontalHandle, @context

    borderH = mk Pt
    add0 borderH.$.x, @$.border, @topLeft.$.x
    add0 borderH.$.y, @midLeft.$.y, val 10
    @handles.define borderH: mk Handle, @context, borderH
    @handles.borderH.decorate HorizontalHandle, @context

  delHandles: ->
    @handles.destructor()
    delete @handles

