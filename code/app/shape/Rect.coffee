Module "shape.Rect"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "shape.Point"
Qualified "constraint.Point", As "Pc"

Register "Obj"
Class

  Rect: (x0, y0, x1, y1) ->

    @define
      p0:     mk Point, x0, y0
      p3:     mk Point, x1, y1
      radius: 0
      border: 0

    @derive
      p1: Pc.yx @p0, @p3
      p2: Pc.xy @p0, @p3

    @derive
      left:   min.f @p0.$.x, @p3.$.x
      top:    min.f @p0.$.y, @p3.$.y
      right:  max.f @p0.$.x, @p3.$.x
      bottom: max.f @p0.$.y, @p3.$.y

    @derive center: Pc.mid @p0, @p3

    @derive
      topLeft:     Pc.topLeft     @p0, @p3
      topRight:    Pc.topRight    @p0, @p3
      bottomLeft:  Pc.bottomLeft  @p0, @p3
      bottomRight: Pc.bottomRight @p0, @p3

    @derive
      midLeft:   Pc.xy @p0, @center
      midTop:    Pc.yx @p0, @center
      midRight:  Pc.xy @p3, @center
      midBottom: Pc.yx @p3, @center

    @derive
      width:  sub0.f @$.right,  @$.left
      height: sub0.f @$.bottom, @$.top

    @

