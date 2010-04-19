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

q = mkPanel()
r = mkPanel()

function mkLine ()
{
  var l = AdjustableLine.make(canvas, 100, 50, 200, 300, 4)
  l.decorate(DraggableShape)
  l.decorate(SelectableShape, selection)
  l.selectable(l.mkHandles, l.delHandles)
  return l
}

s = mkLine()
t = mkLine()

function mkEllipse ()
{
  var e = AdjustableEllipse.make(canvas, 100, 50, 200, 300)
  e.decorate(DraggableShape)
  e.decorate(SelectableShape, selection)
  e.selectable(e.mkHandles, e.delHandles)
  return e
}

u = mkEllipse()
v = mkEllipse()





