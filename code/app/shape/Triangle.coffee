Module "shape.Triangle"

Import "base.Obj"
Import "constraint.Constraint"
Qualified "constraint.Point", "Pc"
Qualified "shape.Point", "Pt"

Class

  Triangle: (revive, ctx, x0, y0, x1, y1) ->
    unless revive
      @define "p0", Pt.make(x0, y0)
      @define "p3", Pt.make(x1, y1)

    Pc.yx (@derive "p1", Pt.make()).v, @p0, @p3
    Pc.xy (@derive "p2", Pt.make()).v, @p0, @p3

    Pc.mid         (@derive "center",      Pt.make()).v, @p0, @p3
    Pc.topLeft     (@derive "topLeft",     Pt.make()).v, @p0, @p3
    Pc.topRight    (@derive "topRight",    Pt.make()).v, @p0, @p3
    Pc.bottomLeft  (@derive "bottomLeft",  Pt.make()).v, @p0, @p3
    Pc.bottomRight (@derive "bottomRight", Pt.make()).v, @p0, @p3
    Pc.xy          (@derive "midLeft",     Pt.make()).v, @p0, @center
    Pc.xy          (@derive "midRight",    Pt.make()).v, @p1, @center
    Pc.yx          (@derive "midTop",      Pt.make()).v, @p0, @center
    Pc.yx          (@derive "midBottom",   Pt.make()).v, @p2, @center

    sub0 (@derive "width",   0), @bottomRight.$.x, @topLeft.$.x
    sub0 (@derive "height",  0), @bottomRight.$.y, @topLeft.$.y
    min0 (@derive "left",    0), @p0.$.x,          @p3.$.x
    min0 (@derive "top",     0), @p0.$.y,          @p3.$.y
    max0 (@derive "right",   0), @p0.$.x,          @p3.$.x
    max0 (@derive "bottom",  0), @p0.$.y,          @p3.$.y

Static

  init: -> Obj.register Triangle

  make: (args...) -> (new Obj "Triangle").decorate Triangle, null, args...

