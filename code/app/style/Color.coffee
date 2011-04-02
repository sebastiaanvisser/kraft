Module "style.Color"

Import "Units"
Import "base.Obj"
Import "base.Value"

Register "Obj"
Class

  Color: (hex) ->
    @define
      red:   0
      green: 0
      blue:  0
      alpha: 1

    @derive
      hex:  "#000000"
      rgba: "rgba(0,0,0,1)"

    channelsToHex  @$.hex,  @$.red, @$.green, @$.blue
    channelsToRgba @$.rgba, @$.red, @$.green, @$.blue, @$.alpha
    @hex = hex if hex
    @

Static

  padded: (v) -> w = v.toString(16); if w.length == 1 then '0' + w else w

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

  Stage
  channelsToHex: -> constraint "channelsToHex", 1
    , (c, r, g, b) ->
        r.v = parseInt (c.v.slice 1, 3), 16
        g.v = parseInt (c.v.slice 3, 5), 16
        b.v = parseInt (c.v.slice 5, 7), 16
    , ((c, r, g, b) -> c.v = '#' + (padded r.v) + (padded g.v) + (padded b.v))
    , ((c, r, g, b) -> c.v = '#' + (padded r.v) + (padded g.v) + (padded b.v))
    , ((c, r, g, b) -> c.v = '#' + (padded r.v) + (padded g.v) + (padded b.v))

  Stage
  channelsToRgba: -> constraint "channelsToRgba", 1
    , (c, r, g, b, a) ->
        s = c.v.match /[\d.]+/g
        r.v = 1 * s[0]
        g.v = 1 * s[1]
        b.v = 1 * s[2]
        a.v = 1 * s[3]
    , ((c, r, g, b, a) -> c.v = "rgba(" + r.v + "," + g.v + "," + b.v + "," + a.v + ")")
    , ((c, r, g, b, a) -> c.v = "rgba(" + r.v + "," + g.v + "," + b.v + "," + a.v + ")")
    , ((c, r, g, b, a) -> c.v = "rgba(" + r.v + "," + g.v + "," + b.v + "," + a.v + ")")
    , ((c, r, g, b, a) -> c.v = "rgba(" + r.v + "," + g.v + "," + b.v + "," + a.v + ")")

