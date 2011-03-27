Module "style.Color"

Import "Units"
Import "base.Obj"
Import "base.Trigger"

Class

  Color: (revive, hex) ->
    @define "red",   0
    @define "green", 0
    @define "blue",  0
    @define "alpha", 1
    @define "hex",   "#000000"
    @define "rgba",  "rgba(0,0,0,1)"
    @$.hex.normalize  = normalizeHex
    @$.rgba.normalize = normalizeRgba
    channelsToHex  @$.hex,  @$.red, @$.green, @$.blue
    channelsToRgba @$.rgba, @$.red, @$.green, @$.blue, @$.alpha
    @hex = hex if hex
    @

Static

  init: -> Obj.register Color

  make: (args...) -> (new Obj).decorate Color, args...

  channelsToHex: (c, r, g, b) ->
    Trigger.compose c, (-> '#' + (padded r.v) + (padded g.v) + (padded b.v) )
                  , r, (-> parseInt (c.v.slice 1, 3), 16)
                  , g, (-> parseInt (c.v.slice 3, 5), 16)
                  , b, (-> parseInt (c.v.slice 5, 7), 16)

  padded: (v) -> w = v.toString(16); if w.length == 1 then '0' + w else w

  channelsToRgba: (c, r, g, b, a) ->
    Trigger.compose c, (-> "rgba(" + r.v + "," + g.v + "," + b.v + "," + a.v + ")" )
                  , r, (-> 1 * (c.v.match /[\d.]+/g)[0])
                  , g, (-> 1 * (c.v.match /[\d.]+/g)[1])
                  , b, (-> 1 * (c.v.match /[\d.]+/g)[2])
                  , a, (-> 1 * (c.v.match /[\d.]+/g)[3])

  # Normalize different types of hex inputs to a # + 6-digit normal form.
  normalizeHex: (c) ->
    switch c.length
      when 3 then '#'  + c[0] + c[0] + c[1] + c[1] + c[2] + c[2]
      when 4 then c[0] + c[1] + c[1] + c[2] + c[2] + c[3] + c[3]
      when 6 then '#' + c
      else c

  normalizeRgba: (c) ->
    s = c.match /[\d.]+/g
    "rgba(" + s[0] + "," + s[1] + "," + s[2] + "," + s[3] + ")"

