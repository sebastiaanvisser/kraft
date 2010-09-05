function Model (revive, ctx)
{
  this.def("shapes", {});
}

Base.register(Model)

Model.make =
function make ()
{
  var m = new Base
  m.decorate(Model)
  return m
}

Class(Model,

  function addShape (shape)
  {
    this.shapes[shape.id] = shape;
  }

)

