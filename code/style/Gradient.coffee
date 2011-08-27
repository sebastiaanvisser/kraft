Module "style.Gradient"

Import "base.Obj"
Import "base.List"

Register "Obj"
Class

  Gradient: ->
    @define ramp: mk List, []

    @derive webkitSteps: @ramp.map (x) -> x.red

    @derive webkit: ""

    @ramp.onchange =>
      @makeWebkitDefinition()
      $(".mydocument").css "background", @webkit

  makeWebkitDefinition: ->
    stops = ("color-stop(" + g.v[1][0] + "," + g.v[1][1].rgba + ")" for g in @ramp.list).join ", "
    @webkit = "-webkit-gradient(linear, left top, left bottom, " + stops + ")"


