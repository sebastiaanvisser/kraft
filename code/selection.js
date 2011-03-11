Module("Selection")

Class
(

  function Selection ()
  {
    this.selectable = {}
    this.selected   = {}
    this.active     = true
  },

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

