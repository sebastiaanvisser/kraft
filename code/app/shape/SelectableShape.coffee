Module "shape.SelectableShape"

Import "base.Obj"
Qualified "Events", "E"

Class

  SelectableShape: ->
    @onselect   = []
    @ondeselect = []
    @selection  = @model.selection

    @selection.selectable[@id] = @

    E.manager.bind @model.canvas.canvasElem, "mousedown", =>
      @selection.deselectAll()

    E.manager.bind @elem, "mousedown", (e) =>
      return @selection.deselect @ if e.altKey
      @selection.deselectAll() if !e.shiftKey
      @selection.select @
      return false

    @onselect.push   => $(@.elem).addClass    "selected"
    @ondeselect.push => $(@.elem).removeClass "selected"

  destructor: ->
    delete @selection.selectable[@id]

  select:   -> @model.canvas.selection.select   @
  deselect: -> @model.canvas.selection.deselect @

Static

  init: -> Obj.register SelectableShape

