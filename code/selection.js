function Selection ()
{
  this.selectable = {}
  this.selected   = {}

  var me = this
  Events.manager.bind(document, "keypress",
    function (e)
    {
      if (e.charCode == 100) // d
        for (var s in me.selected)
        {
          me.selected[s].destructor()
          delete me.selectable[s]
        }
        me.deselectAll()

    })

}

Class(Selection,

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

