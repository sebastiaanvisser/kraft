var canvas = $("#canvas")[0]

selection = new Selection

function mkPanel ()
{
  var r = AdjustableRect.make(canvas, 100, 50, 200, 300)
  r.decorate(DraggableShape)
  r.decorate(SelectableShape, selection)
  r.selectable(r.mkHandles, r.delHandles)
  r.elem.className += " panel"
  return r
}

r = mkPanel()
q = mkPanel()
s = mkPanel()
t = mkPanel()



