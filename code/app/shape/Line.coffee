Module "shape.Line"

Import "base.Obj"
Import "shape.Point"
Qualified "constraint.Point", As "Pc"
Qualified "constraint.Constraint", As "C"

Register "Obj"
Class

  Line: (x0, y0, x1, y1) ->
    @define
      p0: mk Point, x0, y0
      p1: mk Point, x1, y1

#    @derive
#      center:      Pc.mid         @p0, @p1
#      topLeft:     Pc.topLeft     @p0, @p1
#      bottomRight: Pc.bottomRight @p0, @p1

    @derive
      left:   C.min.f @p0.$.x, @p1.$.x
      # top:    C.min.f @p0.$.y, @p1.$.y
      # right:  C.max.f @p0.$.x, @p1.$.x
      # bottom: C.max.f @p0.$.y, @p1.$.y

    @

