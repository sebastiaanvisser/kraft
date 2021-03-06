Module("io.Serializer")

Static
(

  function toXml (o)
  {
    switch (o.constructor.name)
    {
      case "Array"  : return Serializer.arrayToXml   (o)
      case "Object" : return Serializer.objectToXml  (o)
      case "Number" : return Serializer.numberToXml  (o)
      case "String" : return Serializer.strintToXml  (o)
      case "Value"  : return Serializer.propToXml    (o)
      case "Obj"    : return Serializer.baseToXml    (o)
      default       : return Serializer.unknownToXml (o)
    }
  },

  function arrayToXml   (o) { return o.map(Serializer.toXml).join("\n") },
  function numberToXml  (o) { return o.toString() }, 
  function strintToXml  (o) { return o },
  function unknownToXml (o) { return Serializer.elem("unknown", o.constructor.name) },
  function propToXml    (o) { return Serializer.toXml(o.value) },

  function objectToXml (o)
  {
    var prop = function (k, v) { return Serializer.elem("prop", Serializer.toXml(v), { key : k }) }
    return Serializer.elem("Object", foreach(o, prop).join("\n"))
  },

  function baseToXml (o)
  {
    var ctors = values(o.meta.constructors).map(function (k) { return k.name }).join(" ")
    var xs = []
    foreach(o.$, function (k, v) { if (!v.soft) xs.push(Serializer.elem(k, Serializer.toXml(v) , v.type ? {type:v.type} : undefined)) })
    return Serializer.elem("Obj", xs.join("\n"), { id : o.id, type : ctors })
  },

// Helpers.

  function indent (x)
  {
    return "  " + x.split("\n").join("\n  ")
  },

  function elem (tag, sub, attrs)
  {
    // tag = tag.toLowerCase()
    var as = attrs ? " " + foreach(attrs, function (k, v) { return k + '="' + v + '"' }).join(" ") : ""
    var children = (sub && sub.match("\n")) ? "\n" + Serializer.indent(sub) + "\n" : sub
    return sub ? "<" + tag + as + ">" + children + "</" + tag + ">"
               : "<" + tag + as + "/>"
  }

)

Module("io.Deserializer")

Static
( 

  function fromXml (x)
  {
    switch (x.nodeName)
    {
      case "Array"  : return Deserializer.arrayFromXml   (x) 
      case "Object" : return Deserializer.objectFromXml  (x) 
      case "Number" : return Deserializer.numberFromXml  (x) 
      case "String" : return Deserializer.strintFromXml  (x) 
      case "Value"  : return Deserializer.propFromXml    (x)
      case "Obj"    : return Deserializer.baseFromXml    (x)
      default       : return Deserializer.unknownFromXml (x)
    }
  },

  function objectFromXml (x)
  {
    var obj = {}
    var value = function (i, nd) { obj[$(nd).attr("key")] = Deserializer.fromXml($(nd).children().get(0)) }
    $(x).children().each(value)
    return obj
  },

  function unknownFromXml (x)
  {
    throw {"Deserializer: unregistered tag" : x }
    return null;
  },

  function propFromXml (x)
  {
    if ($(x).children().length)
      return Deserializer.fromXml($(x).children().get(0))
    else
      return x.textContent
  },

  function baseFromXml (x)
  {
    var base = new Obj

    $(x).children().each(function (_, nd)
      {
        base.$[nd.nodeName] =
          new Value( Deserializer.propFromXml(nd)
                   , base
                   , nd.nodeName
                   , false
                   , $(nd).attr("type")
                   )
      })

    $(x).attr("type").split(/\s+/).map(
      function (c, i)
      {
        var ctor = Obj.classes[c]
        if (!ctor) throw ("Deserializer.baseFromXml: unregistered class '" + c + "'")
        base.revive(ctor, myCanvas)
      })

    return base
  }

)

