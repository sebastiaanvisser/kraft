Module "shape.Point"

Import "base.Obj"

Register "Obj"
Class

  Point: (x, y) ->
    @define
      x: x || 0
      y: y || 0
    @

