Module "shape.DraggableShape"

Import "Draggable"
Import "base.Obj"

Class
  DraggableShape: ->
    @dragger = new Draggable @model.canvas.canvasElem, @, @elem, false, false, 5, 5, @model.canvas.$.zoom

Static
  init: -> Obj.register DraggableShape

