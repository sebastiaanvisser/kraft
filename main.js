var App =
  { canvas    : $("#canvas")[0]
  , selection : new Selection
  , renderer  : new Renderer
  }

function mkRect ()
{
  var r = AdjustableRect.make(App.canvas, App.renderer, 100, 100, 200, 300)
  r.decorate(DraggableRect)
  r.decorate(SelectableRect, App.selection)
  r.selectable(r.mkHandles, r.delHandles)
  r.elem.className += " myrect"
  return r
}

function mkLine ()
{
  var l = AdjustableLine.make(App.canvas, App.renderer, 150, 200, 250, 200, 5)
  l.decorate(DraggableRect)
  l.decorate(SelectableRect, App.selection)
  l.selectable(l.mkHandles, l.delHandles)
  l.elem.className += " myline"
  return l
}

function mkEllipse ()
{
  var e = AdjustableEllipse.make(App.canvas, App.renderer, 200, 100, 300, 300)
  e.decorate(DraggableRect)
  e.decorate(SelectableRect, App.selection)
  e.selectable(e.mkHandles, e.delHandles)
  e.elem.className += " myellipse"
  return e
}

$("#toolbar #rect").click(mkRect)
$("#toolbar #line").click(mkLine)
$("#toolbar #ellipse").click(mkEllipse)
$("#toolbar #selectall").click(function () { App.selection.selectAll() })
$("#toolbar #deselectall").click(function () { App.selection.deselectAll() })


r = mkRect()
e = mkEllipse()
l = mkLine()

Point.eq(r.center, l.p0)
Point.eq(e.center, l.p1)

