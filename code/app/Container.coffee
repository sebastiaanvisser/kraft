Module "Container"

Import "Events"
Import "Selection"
Import "base.Obj"

Class

  Container: (revive, parent) ->
    @parent = parent
    @define "shapes", {}
    @selection = new Selection
    @

  addShape: (shape) -> @shapes[shape.id] = shape

  delShape: (id) ->
    obj = @shapes[id]
    return unless obj

    delete @shapes[id]
    @selection.deselect obj
    obj.destructor()

Static

  init: -> Obj.register Container

  make: (parent) -> (new Obj "Container").decorate Container, parent

