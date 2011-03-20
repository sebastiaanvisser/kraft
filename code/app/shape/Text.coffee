Module "shape.Text"

Import "base.Obj"
Qualified "constraint.Point", "Pc"
Qualified "constraint.Constraint", "C"
Qualified "shape.Point", "Pt"

Class

  Text: (revive, parent, x0, y0, x1, y1, text) ->
    unless revive
      @define "p0", (Pt.make @, x0, y0)
      @define "p1", (Pt.make @, x1, y1)
      @define "text", text

    @parent = parent

    Pc.mid         (@derive "center",      Pt.make @).v, @p0, @p1
    Pc.topLeft     (@derive "topLeft",     Pt.make @).v, @p0, @p1
    Pc.bottomRight (@derive "bottomRight", Pt.make @).v, @p0, @p1
    
    C.min0 (@derive "left",   0), @p0.$.x, @p1.$.x
    C.min0 (@derive "top",    0), @p0.$.y, @p1.$.y
    C.max0 (@derive "right",  0), @p0.$.x, @p1.$.x
    C.max0 (@derive "bottom", 0), @p0.$.y, @p1.$.y
    @

Static

  init: -> Obj.register Text

  make: (args...) -> (new Obj "Text").decorate Text, args...

