Module "constraint.Constraint"

Import "base.Trigger"

Static

  eq: (a, b) ->      Trigger.compose a, (-> b.v)
                                   , b, (-> a.v)

  add0: (a, b, c) -> Trigger.compose a, (-> b.v + c.v)
                                   , b, (-> a.v - c.v)
                                   , c, (-> c.v)

  sub0: (a, b, c) -> Trigger.compose a, (-> b.v - c.v)
                                   , b, (-> c.v + a.v)
                                   , c, (-> c.v)

  mid: (a, b, c) ->  Trigger.compose a, (-> (b.v + c.v) / 2)
                                   , b, (-> a.v - (c.v - b.v) / 2)
                                   , c, (-> a.v + (c.v - b.v) / 2)

  min: (a, b, c) ->  Trigger.compose a, (-> Math.min b.v, c.v)
                                   , b, (-> if b.v <= c.v then a.v else b.v)
                                   , c, (-> if c.v <  b.v then a.v else c.v)

  max: (a, b, c) ->  Trigger.compose a, (-> Math.max b.v, c.v)
                                   , b, (-> if b.v >= c.v then a.v else b.v)
                                   , c, (-> if c.v >  b.v then a.v else c.v)

  min0: (a, b, c) -> Trigger.compose a, (-> Math.min b.v, c.v)
                                   , b, (-> a.v + if b.v <= c.v then 0 else b.v - c.v)
                                   , c, (-> a.v + if c.v <  b.v then 0 else c.v - b.v)

  max0: (a, b, c) -> Trigger.compose a, (-> Math.max b.v, c.v)
                                   , b, (-> a.v - if b.v >= c.v then 0 else c.v - b.v)
                                   , c, (-> a.v - if c.v >  b.v then 0 else b.v - c.v)


