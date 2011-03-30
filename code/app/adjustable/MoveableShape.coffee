Module "adjustable.MoveableShape"

Import "Dragger"
Import "base.Obj"

Register "Obj"
Class

  MoveableShape: ->
    @dragger = new Dragger @renderContext.elem, @, @elem, false, false, 5, 5, @renderContext.canvas.$.zoom

