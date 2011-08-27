Module "adjustable.SelectableShape"

Import "base.Obj"
Qualified "Events", As "E"

Register "Obj"
Class

  SelectableShape: () ->
    @onselect   = []
    @ondeselect = []

    @context.selection.selectable[@id] = @

    E.manager.bind @context.elem, "mousedown", (e) => @handleDeselect(e)
    E.manager.bind @elem,               "mousedown", (e) => @handleSelect(e)

    @onselect.push   => $(@.elem).addClass    "selected"
    @ondeselect.push => $(@.elem).removeClass "selected"

  destructor: -> delete @context.selection.selectable[@id]

  handleDeselect: (e) -> @context.selection.deselectAll()

  handleSelect: (e) ->
    return @context.selection.deselect @ if e.altKey
    @context.selection.deselectAll() if !e.shiftKey
    @context.selection.select @
    false

  select:   -> @context.selection.select   @
  deselect: -> @context.selection.deselect @

