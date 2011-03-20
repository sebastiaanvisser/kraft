Module "shape.Line"

Import "base.Obj"
Qualified "constraint.Point", "Pc"
Qualified "constraint.Constraint", "C"
Qualified "shape.Point", "Pt"

Class

  Line: (revive, parent, p0, p1, w) ->
    unless revive
      @define "p0", p0
      @define "p1", p1
      @define "width", w

    @parent = parent

    Pc.mid          @derive("center",      Pt.make @).v, @p0, @p1
    Pc.topLeft      @derive("topLeft",     Pt.make @).v, @p0, @p1
    Pc.bottomRight  @derive("bottomRight", Pt.make @).v, @p0, @p1
    
    C.min0 @define("left",   0), @p0.$.x, @p1.$.x
    C.min0 @define("top",    0), @p0.$.y, @p1.$.y
    C.max0 @define("right",  0), @p0.$.x, @p1.$.x
    C.max0 @define("bottom", 0), @p0.$.y, @p1.$.y
    @

Static

  init: -> Obj.register Line

  make: (args...) -> (new Obj).decorate Line, args...

