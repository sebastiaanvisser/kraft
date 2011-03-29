Module "style.Gradient"

Import "base.Obj"
Import "base.List"

Register "Obj"
Class

  Gradient: ->
    @define "ramp", List.make []

    @derive "webkit", ""

    @ramp.onchange => @makeWebkitDefinition()

  makeWebkitDefinition: ->
    stops = ("color-stop(" + g.v[1][0] + "," + g.v[1][1].rgba + ")" for g in @ramp.list).join ", "
    @webkit = "-webkit-gradient(linear, left top, left bottom, " + stops + ")"


