Module "Selection"

Class

  Selection: ->
    @selectable = {}
    @selected   = {}
    @active     = true
    @

  mkSelectable: (obj) -> obj.selection = @

  select: (obj) ->
    return if @selected[obj.id]
    @selected[obj.id] = obj
    s.call obj for s in obj.onselect when s

  deselect: (obj) ->
    return unless @selected[obj.id]
    delete @selected[obj.id]
    d.call obj for d in obj.ondeselect when d

  selectAll:   -> @select   s for _, s of @selectable
  deselectAll: -> @deselect s for _, s of @selected

