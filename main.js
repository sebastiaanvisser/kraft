var canvas = $("#canvas")[0]

selection = new Selection

function mkRect ()
{
  var r = AdjustableRect.make(canvas, 100, 50, 200, 300)
  r.decorate(DraggableShape)
  r.decorate(SelectableShape, selection)
  r.selectable(r.mkHandles, r.delHandles)
  return r
}

function mkLine ()
{
  var l = AdjustableLine.make(canvas, 100, 50, 200, 300, 4)
  l.decorate(DraggableShape)
  l.decorate(SelectableShape, selection)
  l.selectable(l.mkHandles, l.delHandles)
  return l
}

function mkEllipse ()
{
  var e = AdjustableEllipse.make(canvas, 100, 50, 200, 300)
  e.decorate(DraggableShape)
  e.decorate(SelectableShape, selection)
  e.selectable(e.mkHandles, e.delHandles)
  return e
}

$("#toolbar #rect").click(mkRect)
$("#toolbar #line").click(mkLine)
$("#toolbar #ellipse").click(mkEllipse)
$("#toolbar #selectall").click(function () { selection.selectAll() })
$("#toolbar #deselectall").click(function () { selection.deselectAll() })


r = mkRect()
l = mkLine()
mkEllipse()

C.eq(r.right, l.p0.x)
C.eq(r.top,   l.p0.y)

