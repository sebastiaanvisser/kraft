Module("ui.Setup")

Import("Canvas")
Import("Events")
// Import("shape.Ellipse")
// Import("shape.Line")
Import("shape.Rect")
Import("shape.RenderableRect")
Import("shape.SelectableShape")
Import("shape.AdjustableRect")
Import("shape.DraggableShape")
// Import("shape.Text")
// Import("shape.Triangle")

Static
(

  function mkRect (canvas)
  {
    r = Rect.make(300, 100, 200, 300)
    r.decorate(RenderableRect, canvas.model)
    r.decorate(SelectableShape)
    r.decorate(AdjustableRect)
    r.decorate(DraggableShape)
    canvas.model.addShape(r);
    $(r.elem).addClass("myrect")
    $(r.elem).addClass("shape")
    return r
  },

  function mkEllipse (canvas)
  {
    e = Rect.make(300, 100, 200, 300)
    e.decorate(RenderableEllipse, canvas.model)
    e.decorate(SelectableShape)
    e.decorate(AdjustableRect)
    e.decorate(DraggableShape)
    canvas.model.addShape(e);
    $(e.elem).addClass("myellipse")
    $(e.elem).addClass("shape")
    return e
  },

  function mkTriangle (canvas)
  {
    var shp = AdjustableTriangle.make(canvas.model, 100, 100, 200, 200)
    shp.decorate(DraggableShape)
    canvas.model.addShape(shp);
    $(shp.elem).addClass("mytriangle")
    $(shp.elem).addClass("shape")
    return shp
  },

  function mkLine (canvas)
  {
    var shp = AdjustableLine.make(canvas.model, 150, 200, 250, 200, 20)
    shp.decorate(DraggableShape)
    canvas.model.addShape(shp);
    $(shp.elem).addClass("myline")
    return shp
  },

  function mkText (canvas, text)
  {
    var shp = AdjustableText.make(canvas.model, 150, 200, 250, 200, text)
    shp.decorate(DraggableShape)
    canvas.model.addShape(shp);
    $(shp.elem).addClass("mytext")
    $(shp.elem).attr("contentEditable", true)
    return shp
  },

  function init ()
  {
    window.myCanvas = Canvas.make($("#mycanvas")[0])

    Events.manager.bind("#toolbar #rect",        "click", function () { mkRect(myCanvas) })
    Events.manager.bind("#toolbar #line",        "click", function () { mkLine(myCanvas) })
    Events.manager.bind("#toolbar #triangle",    "click", function () { mkTriangle(myCanvas) })
    Events.manager.bind("#toolbar #ellipse",     "click", function () { mkEllipse(myCanvas) })
    Events.manager.bind("#toolbar #text",        "click", function () { mkText(myCanvas, prompt() || "...") })
    Events.manager.bind("#toolbar #selectall",   "click", function () { myCanvas.selection.selectAll() })
    Events.manager.bind("#toolbar #deselectall", "click", function () { myCanvas.selection.deselectAll() })
    Events.manager.bind("#toolbar #togglegrid",  "click", function () { myCanvas.gridShow ? myCanvas.hideGrid() : myCanvas.showGrid() })
    Events.manager.bind("#toolbar #zoomin",      "click", function () { myCanvas.zoomIn() })
    Events.manager.bind("#toolbar #zoomout",     "click", function () { myCanvas.zoomOut() })
    Events.manager.bind("#toolbar #zoomreset",   "click", function () { myCanvas.zoomReset() })
    Events.manager.bind("#toolbar #save",        "click", function () { IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(myCanvas.model)) })
    Events.manager.bind("#toolbar #load",        "click", function () { IO.load("mymodel.xml", function (x) { Deserializer.baseFromXml(x.documentElement) }) })
  }

)

