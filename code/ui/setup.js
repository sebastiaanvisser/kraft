var myCanvas = Canvas.make($("#mycanvas")[0])

function mkRect ()
{
  r = Rect.make(300, 100, 200, 300)
  r.decorate(RenderableRect, myCanvas.model)
  r.decorate(SelectableShape)
  r.decorate(AdjustableRect)
  r.decorate(DraggableShape)
  myCanvas.model.addShape(r);
  $(r.elem).addClass("myrect")
  $(r.elem).addClass("shape")
  return r
}

function mkEllipse ()
{
  e = Rect.make(300, 100, 200, 300)
  e.decorate(RenderableEllipse, myCanvas.model)
  e.decorate(SelectableShape)
  e.decorate(AdjustableRect)
  e.decorate(DraggableShape)
  myCanvas.model.addShape(e);
  $(e.elem).addClass("myellipse")
  $(e.elem).addClass("shape")
  return e
}

function mkTriangle ()
{
  var shp = AdjustableTriangle.make(myCanvas.model, 100, 100, 200, 200)
  shp.decorate(DraggableShape)
  myCanvas.model.addShape(shp);
  $(shp.elem).addClass("mytriangle")
  $(shp.elem).addClass("shape")
  return shp
}

function mkLine ()
{
  var shp = AdjustableLine.make(myCanvas.model, 150, 200, 250, 200, 20)
  shp.decorate(DraggableShape)
  myCanvas.model.addShape(shp);
  $(shp.elem).addClass("myline")
  return shp
}

function mkText (text)
{
  var shp = AdjustableText.make(myCanvas.model, 150, 200, 250, 200, text)
  shp.decorate(DraggableShape)
  myCanvas.model.addShape(shp);
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
Events.manager.bind("#toolbar #zoomin",      "click", function () { myCanvas.zoomIn() })
Events.manager.bind("#toolbar #zoomout",     "click", function () { myCanvas.zoomOut() })
Events.manager.bind("#toolbar #zoomreset",   "click", function () { myCanvas.zoomReset() })
Events.manager.bind("#toolbar #save",        "click", function () { IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(myCanvas.model)) })
Events.manager.bind("#toolbar #load",        "click", function () { IO.load("mymodel.xml", function (x) { Deserializer.baseFromXml(x.documentElement) }) })

