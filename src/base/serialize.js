function Serializer () {}

Static
( Serializer,

  function toXml (o)
  {
    switch (o.constructor.name)
    {
      case "Array"  : return Serializer.arrayToXml   (o) 
      case "Object" : return Serializer.objectToXml  (o) 
      case "Number" : return Serializer.numberToXml  (o) 
      case "String" : return Serializer.strintToXml  (o) 
      case "Prop"   : return Serializer.propToXml    (o)
      case "Base"   : return Serializer.baseToXml    (o)
      default       : return Serializer.unknownToXml (o)
    }
  },

  function arrayToXml   (o) { return o.map(Serializer.toXml).join("\n") },
  function objectToXml  (o) { return values(o).map(Serializer.toXml).join("\n") },
  function numberToXml  (o) { return o.toString() }, 
  function strintToXml  (o) { return o },
  function unknownToXml (o) { return Serializer.toElem("unknown", o.constructor.name) },
  function propToXml    (o) { return Serializer.toXml(o.value) },

  function baseToXml (o)
  {
    var as = { id : o.id }
    var cs = []
    foreach(o.$, function (k, v) { if (!v.soft) cs.push(Serializer.toElem(k, Serializer.toXml(v))) })
    return Serializer.toElem(o.meta.constructors[0].name, cs.join("\n"), as)
  },

// Helpers.

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

