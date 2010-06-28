var myCanvas = new Canvas($("#canvas")[0])
var myModel  = Model.make();

function mkRect ()
{
  var shp = AdjustableRect.make(myCanvas, 100, 100, 200, 300)
  myModel.addShape(shp);
  shp.decorate(DraggableRect)
  shp.decorate(SelectableRect)
  shp.selectable(shp.mkHandles, shp.delHandles)
  $(shp.elem).addClass("myrect")
  $(shp.elem).addClass("shape")
  return shp
}

function mkTriangle ()
{
  var shp = AdjustableTriangle.make(myCanvas, 100, 100, 200, 200)
  myModel.addShape(shp);
  shp.decorate(DraggableRect)
  shp.decorate(SelectableRect)
  shp.selectable(shp.mkHandles, shp.delHandles)
  $(shp.elem).addClass("mytriangle")
  $(shp.elem).addClass("shape")
  return shp
}

function mkLine ()
{
  var shp = AdjustableLine.make(myCanvas, 150, 200, 250, 200, 4)
  myModel.addShape(shp);
  shp.decorate(DraggableRect)
  shp.decorate(SelectableRect)
  shp.selectable(shp.mkHandles, shp.delHandles)
  $(shp.elem).addClass("myline")
  return shp
}

function mkEllipse ()
{
  var shp = AdjustableEllipse.make(myCanvas, 200, 100, 300, 300)
  myModel.addShape(shp);
  shp.decorate(DraggableRect)
  shp.decorate(SelectableRect)
  shp.selectable(shp.mkHandles, shp.delHandles)
  $(shp.elem).addClass("myellipse")
  $(shp.elem).addClass("shape")
  return shp
}

function mkText (text)
{
  var shp = AdjustableText.make(myCanvas, 150, 200, 250, 200, text)
  myModel.addShape(shp);
  shp.decorate(DraggableRect)
  shp.decorate(SelectableRect)
  shp.selectable(shp.mkHandles, shp.delHandles)
  $(shp.elem).addClass("mytext")
  $(shp.elem).attr("contentEditable", true)
  return shp
}

Events.manager.bind("#toolbar #rect",        "click", mkRect)
Events.manager.bind("#toolbar #line",        "click", mkLine)
Events.manager.bind("#toolbar #triangle",    "click", mkTriangle)
Events.manager.bind("#toolbar #ellipse",     "click", mkEllipse)
Events.manager.bind("#toolbar #text",        "click", function () { mkText(prompt()) })
Events.manager.bind("#toolbar #selectall",   "click", function () { myCanvas.selection.selectAll() })
Events.manager.bind("#toolbar #deselectall", "click", function () { myCanvas.selection.deselectAll() })
Events.manager.bind("#toolbar #togglegrid",  "click", function () { myCanvas.gridShow ? myCanvas.hideGrid() : myCanvas.showGrid() })

