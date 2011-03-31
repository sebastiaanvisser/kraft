Module "shape.Line"

Import "base.Obj"
Qualified "constraint.Point", As "Pc"
Qualified "constraint.Constraint", As "C"

Register "Obj"
Class

  Line: (p0, p1) ->
    @define
      p0: p0
      p1: p1

      # @define "width", w

    @derive
      center:      Pc.mid         @p0, @p1
      topLeft:     Pc.topLeft     @p0, @p1
      bottomRight: Pc.bottomRight @p0, @p1

    @derive
      left:   C.min.f @p0.$.x, @p1.$.x
      top:    C.min.f @p0.$.y, @p1.$.y
      right:  C.max.f @p0.$.x, @p1.$.x
      bottom: C.max.f @p0.$.y, @p1.$.y

    @

