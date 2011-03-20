Module "shape.SelectableShape"

Import "base.Obj"
Qualified "Events", "E"

Class

  SelectableShape: ->
    @onselect   = []
    @ondeselect = []
    @selection  = @model.selection

    @selection.selectable[@id] = @

    E.manager.bind @model.canvas.canvasElem, "mousedown", (e) => @handleDeselect(e)
    E.manager.bind @elem,                    "mousedown", (e) => @handleSelect(e)

    @onselect.push   => $(@.elem).addClass    "selected"
    @ondeselect.push => $(@.elem).removeClass "selected"

  destructor: -> delete @selection.selectable[@id]

  handleDeselect: (e) -> @selection.deselectAll()

  handleSelect: (e) ->
    return @selection.deselect @ if e.altKey
    @selection.deselectAll() if !e.shiftKey
    @selection.select @
    false

  select:   -> @model.canvas.selection.select   @
  deselect: -> @model.canvas.selection.deselect @

Static

  init: -> Obj.register SelectableShape

