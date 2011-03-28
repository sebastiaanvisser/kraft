Module "Prelude"

Static

  zipWith: (a, b, c) -> c a[i], b[i] for i in [0..(Math.max a.length, b.length) - 1]

  unzip: (xs) ->
    ys = []
    zs = []
    for i in [0..xs.length - 1] by 2
      ys.push xs[i    ]
      zs.push xs[i + 1]
    [ys, zs]

