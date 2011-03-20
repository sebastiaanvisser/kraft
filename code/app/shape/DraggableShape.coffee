Module "shape.DraggableShape"

Import "Draggable"
Import "base.Obj"

Class

  DraggableShape: ->
    @dragger = new Draggable @parentElem, @, @elem, false, false, 5, 5, @canvas.$.zoom

Static init: -> Obj.register DraggableShape

