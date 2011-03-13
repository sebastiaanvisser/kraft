Module "shape.Point"

Import "base.Obj"

Class

  Point: (revive, ctx, x, y) ->
    unless revive
      @define "x", x || 0
      @define "y", y || 0
    @

Static

  init: () -> Obj.register Point

  make: (x, y) ->
    (new Obj "Point").decorate Point, null, x, y

