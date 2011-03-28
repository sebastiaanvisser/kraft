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
      topLeft:     mk Handle, @p0,        @canvas, @renderer, @parentElem
      topRight:    mk Handle, @p1,        @canvas, @renderer, @parentElem
      bottomLeft:  mk Handle, @p2,        @canvas, @renderer, @parentElem
      bottomRight: mk Handle, @p3,        @canvas, @renderer, @parentElem
      midLeft:     mk Handle, @midLeft,   @canvas, @renderer, @parentElem
      midRight:    mk Handle, @midRight,  @canvas, @renderer, @parentElem
      midTop:      mk Handle, @midTop,    @canvas, @renderer, @parentElem
      midBottom:   mk Handle, @midBottom, @canvas, @renderer, @parentElem
      center:      mk Handle, @center,    @canvas, @renderer, @parentElem

    @handles.midLeft.decorate   HorizontalHandle, @canvas, @renderer, @parentElem
    @handles.midRight.decorate  HorizontalHandle, @canvas, @renderer, @parentElem
    @handles.midTop.decorate    VerticalHandle,   @canvas, @renderer, @parentElem
    @handles.midBottom.decorate VerticalHandle,   @canvas, @renderer, @parentElem

    radiusH = mk Pt, 0, 0
    window.radiusH = radiusH
    add0 radiusH.$.y, @topLeft.$.y, val 10
    add0 radiusH.$.x, @$.radius, @topLeft.$.x
    @handles.define radiusH: mk Handle, radiusH, @canvas, @renderer, @parentElem
    @handles.radiusH.decorate HorizontalHandle, @canvas, @renderer, @parentElem

    borderH = mk Pt
    add0 borderH.$.x, @$.border, @topLeft.$.x
    add0 borderH.$.y, @midLeft.$.y, val 10
    @handles.define borderH: mk Handle, borderH, @canvas, @renderer, @parentElem
    @handles.borderH.decorate HorizontalHandle, @canvas, @renderer, @parentElem

  delHandles: -> @handles.destructor()

