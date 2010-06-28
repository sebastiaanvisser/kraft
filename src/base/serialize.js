function Serializer () {}

Static
( Serializer,

  function serializeToXml (obj)
  {
    if (obj.constructor.name == "Array")  return obj.map(Serializer.serializeToXml).join("\n")
    if (obj.constructor.name == "Number") return obj.toString()
    if (obj.constructor.name == "String") return obj

    if (obj.constructor != Base) return Serializer.toElem("unrecognized", Serializer.toElem(obj.constructor.name))

    // var ctors = Serializer.toElem
      // ( "constructors"
      // , obj.meta.constructors
           // .map(function (x) { return Serializer.toElem(x.name) })
           // .join("\n")
      // )
    
    var as = { id : obj.id }
    var cs = []

    foreach(obj.$,
      function (k, v)
      {
        if (v.value.constructor.name == "Number") // || v.value.constructor.name == "String")
          as[k] = v.value
        else
          cs.push(Serializer.toElem(k, serializeToXml(v.value)))
      })

    return Serializer.toElem(obj.meta.constructors[0].name, cs.join("\n"), as)
  },

  function indent (x)
  {
    return "  " + x.split("\n").join("\n  ")
  },

  function toElem (tag, sub, attrs)
  {
    tag = tag.toLowerCase()
    var as = attrs ? " " + foreach(attrs, function (k, v) { return k + '="' + v + '"' }).join(" ") : ""
    var children = (sub && sub.match("\n")) ? "\n" + Serializer.indent(sub) + "\n" : sub
    return sub ? "<" + tag + as + ">" + children + "</" + tag + ">"
               : "<" + tag + as + "/>"
  }

)

