var canvas = $("#canvas")[0]

selection = new Selection

function mkRect ()
{
  var r = AdjustableRect.make(canvas, 100, 50, 200, 300)
  r.decorate(DraggableRect)
  r.decorate(SelectableRect, selection)
  r.selectable(r.mkHandles, r.delHandles)
  return r
}

function mkLine ()
{
  var l = AdjustableLine.make(canvas, 100, 50, 200, 300, 4)
  l.decorate(DraggableRect)
  l.decorate(SelectableRect, selection)
  l.selectable(l.mkHandles, l.delHandles)
  return l
}

function mkEllipse ()
{
  var e = AdjustableEllipse.make(canvas, 100, 50, 200, 300)
  e.decorate(DraggableRect)
  e.decorate(SelectableRect, selection)
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
e = mkEllipse()

C.eq(r.$.right, l.p0.$.x)
C.eq(r.$.top,   l.p0.$.y)

