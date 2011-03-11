Module("shape.Point")

Import("base.Obj")

Class
(

  function Point (revive, ctx, x, y)
  {
    if (!revive)
    {
      this.define("x", x || 0)
      this.define("y", y || 0)
    }
  }

)

Static
(

  function init ()
  {
    Obj.register(Point)
  },

  function make (x, y)
  {
    var p = new Obj
    p.decorate(Point, null, x, y)
    return p
  }

)

