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

function mkTriangle ()
{
  var r = AdjustableTriangle.make(myCanvas, 100, 100, 200, 200)
  r.decorate(DraggableRect)
  r.decorate(SelectableRect)
  r.selectable(r.mkHandles, r.delHandles)
  $(r.elem).addClass("mytriangle")
  $(r.elem).addClass("shape")
  return r
}

function mkLine ()
{
  var l = AdjustableLine.make(myCanvas, 150, 200, 250, 200, 4)
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

function mkText (text)
{
  var l = AdjustableText.make(myCanvas, 150, 200, 250, 200, text)
  l.decorate(DraggableRect)
  l.decorate(SelectableRect)
  l.selectable(l.mkHandles, l.delHandles)
  $(l.elem).addClass("mytext")
  $(l.elem).attr("contentEditable", true)
  return l
}

Events.manager.bind("#toolbar #rect",        "click", mkRect)
Events.manager.bind("#toolbar #line",        "click", mkLine)
Events.manager.bind("#toolbar #triangle",    "click", mkTriangle)
Events.manager.bind("#toolbar #ellipse",     "click", mkEllipse)
Events.manager.bind("#toolbar #text",        "click", function () { mkText(prompt()) })
Events.manager.bind("#toolbar #selectall",   "click", function () { myCanvas.selection.selectAll() })
Events.manager.bind("#toolbar #deselectall", "click", function () { myCanvas.selection.deselectAll() })
Events.manager.bind("#toolbar #togglegrid",  "click", function () { myCanvas.gridShow ? myCanvas.hideGrid() : myCanvas.showGrid() })

r = mkRect()
e = mkEllipse()
l = mkLine()
t = mkText("grotesk")

Point.eq(r.center, t.p0)
Point.eq(e.center, t.p1)

