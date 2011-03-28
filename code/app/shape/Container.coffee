Module "shape.Container"

Import "Events"
Import "Selection"
Import "base.Obj"

Register "Obj"
Class

  Container: ->
    @define shapes: {}
    @selection = new Selection
    @

  addShape: (shape) -> @shapes[shape.id()] = shape

  delShape: (id) ->
    obj = @shapes[id]
    return unless obj

    delete @shapes[id]
    @selection.deselect obj
    obj.destructor()

