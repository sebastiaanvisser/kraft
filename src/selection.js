function Selection ()
{
  this.selectable = {}
  this.selected   = {}
}

addToProto(Selection,

  function mkSelectable (obj)
  {
    obj.selection = this
  },

  function select (obj)
  {
    if (this.selected[obj.id]) return

    this.selected[obj.id] = obj

    for (var i = 0; i < obj.onselect.length; i++)
      if (obj.onselect[i])
        obj.onselect[i].call(obj)
  },

  function deselect (obj)
  {
    if (!this.selected[obj.id]) return

    delete this.selected[obj.id]

    for (var i = 0; i < obj.ondeselect.length; i++)
      if (obj.ondeselect[i])
        obj.ondeselect[i].call(obj)
  },

  function selectAll ()
  {
    for (var s in this.selectable)
      this.select(this.selectable[s])
  },

  function deselectAll ()
  {
    for (var s in this.selected)
      this.deselect(this.selected[s])
  }

)

function SelectableRect ()
{
  this.onselect   = []
  this.ondeselect = []

  var sel = this.canvas.selection
  sel.selectable[this.id] = this

  var self = this
  $(this.canvas.elem).mousedown( function (e) { sel.deselectAll() })
  $(this.elem).mousedown(
    function (e)
    {
      if (e.altKey) return sel.deselect(self)
      if (!e.shiftKey) sel.deselectAll()
      sel.select(self)
    })

  this.selectable
    ( function () { $(self.elem).addClass("selected")    }
    , function () { $(self.elem).removeClass("selected") }
    )
}

addToProto(SelectableRect,

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

