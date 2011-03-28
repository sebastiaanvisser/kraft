Module "visible.VisibleContainer"

Import "Events"
Import "Selection"
Import "base.Obj"

Register "Obj"
Class

  VisibleContainer: (canvas, renderer, elem) ->
    @canvas   = canvas
    @renderer = renderer
    @elem     = elem
    @

