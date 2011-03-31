Module "adjustable.MoveableShape"

Import "Dragger"
Import "base.Obj"

Register "Obj"
Class

  MoveableShape: ->
    @dragger = new Dragger @context.elem, @, @elem, false, false, 5, 5, @context.canvas.$.zoom

