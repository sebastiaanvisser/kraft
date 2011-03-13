Module "Model"

Import "Events"
Import "Selection"
Import "base.Obj"

Class

  Model: (revive, canvas) ->
    @canvas = canvas
    @define "shapes", {}
    @selection = new Selection

    Events.manager.bind document, "keypress", (e) =>
      @delShape @selected[s] for s of @selected if e.charCode is 100 # char: d
    @

  addShape: (shape) ->
    @shapes[shape.id] = shape

  delShape: (id) ->
    obj = @shapes[id]
    return unless obj

    delete @shapes[id]
    @selection.deselect obj
    obj.destructor()

Static

  init: -> Obj.register Model

  make: (canvas) ->
    m = new Obj
    m.decorate Model, canvas
    m

