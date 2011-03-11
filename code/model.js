Module("Model")

Import("Events")
Import("Selection")
Import("base.Obj")

Class(

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

  },

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

Static(

  function init ()
  {
    Obj.register(Model)
  },

  function make (canvas)
  {
    var m = new Obj
    m.decorate(Model, canvas)
    return m
  }

)

