Module "RenderContext"

Import "Events"
Import "Selection"
Import "base.Obj"

Register "Obj"
Class

  RenderContext: (canvas, renderer, elem) ->
    @canvas   = canvas
    @renderer = renderer
    @elem     = elem
    @

