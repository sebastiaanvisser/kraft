Module "shape.Point"

Import "base.Obj"

Class

  Point: (revive, parent, x, y) ->
    unless revive
      @define "x", x || 0
      @define "y", y || 0

    @parent = parent
    @

Static

  init: () -> Obj.register Point

  make: (args...) ->
    (new Obj "Point").decorate Point, args...

