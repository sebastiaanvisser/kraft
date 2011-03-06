function Model (revive, ctx)
{
  this.define("shapes", {});
}

Obj.register(Model)

Model.make =
function make ()
{
  var m = new Obj
  m.decorate(Model)
  return m
}

Class(Model,

  function addShape (shape)
  {
    this.shapes[shape.id] = shape;
  }

)

