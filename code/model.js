function Model (revive, canvas)
{
  this.canvas = canvas
  this.define("shapes", {});
  this.selection = new Selection

  var me = this
  Events.manager.bind(document, "keypress",
    function (e)
    {
      if (e.charCode == 100) // d
        for (var s in me.selected)
          me.delShape(me.selected[s])
    })

}

Obj.register(Model)

Static(Model,

  function make (canvas)
  {
    var m = new Obj
    m.decorate(Model, canvas)
    return m
  }

)

Class(Model,

  function addShape (shape)
  {
    this.shapes[shape.id] = shape;
  },

  function delShape (id)
  {
    var obj = this.shapes[id]
    if (!obj) return

    delete this.shapes[id]
    this.selection.deselect(obj)
    obj.destructor()
  }

)

