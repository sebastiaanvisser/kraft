Module "VisibleContainer"

Import "Events"
Import "Selection"
Import "base.Obj"

Class

  VisibleContainer: (revive) ->
    @canvas   = @parent
    @renderer = @parent.renderer
    @elem     = @parent.elem
    @

Static init: -> Obj.register VisibleContainer

