Module "adjustable.MoveableShape"

Import "Dragger"
Import "base.Obj"

Class

  MoveableShape: ->
    @dragger = new Dragger @parentElem, @, @elem, false, false, 5, 5, @canvas.$.zoom

Static init: -> Obj.register MoveableShape

