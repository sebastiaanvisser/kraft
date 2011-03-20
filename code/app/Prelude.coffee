Module "Prelude"

Static

  zip: (a, b, c) ->
    len = Math.max a.length, b.length
    c a[i], b[i] for i in [0..len - 1]

