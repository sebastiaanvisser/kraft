var myCanvas = new Canvas($("#canvas")[0])

function mkRect ()
{
  var r = AdjustableRect.make(myCanvas, 100, 100, 200, 300)
  r.decorate(DraggableRect)
  r.decorate(SelectableRect)
  r.selectable(r.mkHandles, r.delHandles)
  $(r.elem).addClass("myrect")
  $(r.elem).addClass("shape")
  return r
}

function mkLine ()
{
  var l = AdjustableLine.make(myCanvas, 150, 200, 250, 200, 5)
  l.decorate(DraggableRect)
  l.decorate(SelectableRect)
  l.selectable(l.mkHandles, l.delHandles)
  $(l.elem).addClass("myline")
  return l
}

function mkEllipse ()
{
  var e = AdjustableEllipse.make(myCanvas, 200, 100, 300, 300)
  e.decorate(DraggableRect)
  e.decorate(SelectableRect)
  e.selectable(e.mkHandles, e.delHandles)
  $(e.elem).addClass("myellipse")
  $(e.elem).addClass("shape")
  return e
}

$("#toolbar #rect").click(mkRect)
$("#toolbar #line").click(mkLine)
$("#toolbar #ellipse").click(mkEllipse)
$("#toolbar #selectall").click(function () { myCanvas.selection.selectAll() })
$("#toolbar #deselectall").click(function () { myCanvas.selection.deselectAll() })
$("#toolbar #togglegrid").click(function () { myCanvas.gridShow ? myCanvas.hideGrid() : myCanvas.showGrid() })


r = mkRect()
e = mkEllipse()
l = mkLine()

// Point.eq(r.center, l.p0)
// Point.eq(e.center, l.p1)

