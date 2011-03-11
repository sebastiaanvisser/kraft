Module("shape.SelectableShape")

Import("Events")
Import("base.Obj")

Class
(

  function SelectableShape ()
  {
    this.onselect   = []
    this.ondeselect = []

    var sel = this.model.selection
    sel.selectable[this.id] = this

    var self = this

    Events.manager.bind(this.model.canvas.canvasElem, "mousedown",
      function (e) { sel.deselectAll() })

    Events.manager.bind(this.elem, "mousedown",
      function (e)
      {
        if (e.altKey) return sel.deselect(self)
        if (!e.shiftKey) sel.deselectAll() // TODO: don't select when is equal to new selection
        sel.select(self)
      })

    this.selectable
      ( function () { $(self.elem).addClass("selected")    }
      , function () { $(self.elem).removeClass("selected") }
      )
  },

  function selectable (s, d)
  {
    this.onselect.push(s)
    this.ondeselect.push(d)
  },

  function select ()
  {
    this.model.canvas.selection.select(this)
  },

  function deselect ()
  {
    this.model.canvas.selection.deselect(this)
  }

)

Static
(

  function init ()
  {
    Obj.register(SelectableShape)
  }

)

Module("shape.DraggableShape")

Import("Draggable")
Import("base.Obj")

Class
(

  function DraggableShape ()
  {
    this.dragger = new Draggable(this.model.canvas.canvasElem, this, this.elem, false, false, 5, 5, this.model.canvas.$.zoom)
  }

)

Static
(

  function init ()
  {
    Obj.register(DraggableShape)
  }

)

