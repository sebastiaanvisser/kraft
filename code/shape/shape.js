function SelectableShape ()
{
  this.onselect   = []
  this.ondeselect = []

  var sel = this.canvas.selection
  sel.selectable[this.id] = this

  var self = this

  Events.manager.bind(this.canvas.elem, "mousedown",
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
}

Obj.register(SelectableShape)

Class(SelectableShape,

  function selectable (s, d)
  {
    this.onselect.push(s)
    this.ondeselect.push(d)
  },

  function select ()
  {
    this.canvas.selection.select(this)
  },

  function deselect ()
  {
    this.canvas.selection.deselect(this)
  }

)

// ----------------------------------------------------------------------------

function DraggableShape ()
{
  this.dragger = new Draggable(this.canvas.elem, this, this.elem, false, false, 5, 5)
}

Obj.register(DraggableShape)

