var canvas = $("#canvas")[0]

selection = new Selection

function mkPanel ()
{
  var r = AdjustableRect.make(canvas, 100, 50, 200, 300)
  r.decorate(DraggableShape)
  r.decorate(SelectableShape, selection)
  r.selectable(r.mkHandles, r.delHandles)
  return r
}

r = mkPanel()
q = mkPanel()

function mkLine ()
{
  var l = AdjustableLine.make(canvas, 100, 50, 200, 300, 20)
  l.decorate(DraggableShape)
  l.decorate(SelectableShape, selection)
  l.selectable(l.mkHandles, l.delHandles)
  return l
}

s = mkLine()
t = mkLine()



