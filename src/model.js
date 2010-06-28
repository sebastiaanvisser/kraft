function Model ()
{
  this.def("shapes", {});
}

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

