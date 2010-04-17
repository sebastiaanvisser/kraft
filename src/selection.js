Selection = { selected : [] }

Selection.mkSelectable =
function mkSelectable (obj)
{
  obj.selection = {}

  $(document.body).mousedown(
    function ()
    {
      Selection.selected.map(Selection.deselect)
    })

  $(obj.elem).mousedown(
    function ()
    {
      Selection.selected.map(Selection.deselect)
      Selection.select(obj)
    })
}


Selection.deselect =
function deselect (obj)
{
  Selection.selected = []
  obj.removeHandles()
}

Selection.select =
function select (obj)
{
  Selection.selected = [obj]
  obj.mkHandles()
}


