Module "ui.Setup"

Import "Canvas"
Qualified "Events", "E"

# Import("shape.Ellipse")
# Import("shape.Line")
# Import("shape.Rect")
# Import("shape.RenderableRect")
# Import("shape.SelectableShape")
# Import("shape.AdjustableRect")
# Import("shape.DraggableShape")
# Import("shape.Text")
# Import("shape.Triangle")

Static

#  function mkRect (canvas)
#  {
#    r = Rect.make(300, 100, 200, 300)
#    r.decorate(RenderableRect, canvas.model)
#    r.decorate(SelectableShape)
#    r.decorate(AdjustableRect)
#    r.decorate(DraggableShape)
#    canvas.model.addShape(r);
#    $(r.elem).addClass("myrect")
#    $(r.elem).addClass("shape")
#    return r
#  },
#
#  function mkEllipse (canvas)
#  {
#    e = Rect.make(300, 100, 200, 300)
#    e.decorate(RenderableEllipse, canvas.model)
#    e.decorate(SelectableShape)
#    e.decorate(AdjustableRect)
#    e.decorate(DraggableShape)
#    canvas.model.addShape(e);
#    $(e.elem).addClass("myellipse")
#    $(e.elem).addClass("shape")
#    return e
#  },
#
#  function mkTriangle (canvas)
#  {
#    var shp = AdjustableTriangle.make(canvas.model, 100, 100, 200, 200)
#    shp.decorate(DraggableShape)
#    canvas.model.addShape(shp);
#    $(shp.elem).addClass("mytriangle")
#    $(shp.elem).addClass("shape")
#    return shp
#  },
#
#  function mkLine (canvas)
#  {
#    var shp = AdjustableLine.make(canvas.model, 150, 200, 250, 200, 20)
#    shp.decorate(DraggableShape)
#    canvas.model.addShape(shp);
#    $(shp.elem).addClass("myline")
#    return shp
#  },
#
#  function mkText (canvas, text)
#  {
#    var shp = AdjustableText.make(canvas.model, 150, 200, 250, 200, text)
#    shp.decorate(DraggableShape)
#    canvas.model.addShape(shp);
#    $(shp.elem).addClass("mytext")
#    $(shp.elem).attr("contentEditable", true)
#    return shp
#  },

  init: ->
    window.myCanvas = Canvas.make $("#mycanvas")[0]

 #   E.manager.bind("#toolbar #rect",        "click", () -> mkRect(myCanvas)
 #   E.manager.bind("#toolbar #line",        "click", () -> mkLine(myCanvas)
 #   E.manager.bind("#toolbar #triangle",    "click", () -> mkTriangle(myCanvas)
 #   E.manager.bind("#toolbar #ellipse",     "click", () -> mkEllipse(myCanvas)
 #   E.manager.bind("#toolbar #text",        "click", () -> mkText(myCanvas, prompt() || "...")
 #   E.manager.bind("#toolbar #selectall",   "click", () -> myCanvas.selection.selectAll()
 #   E.manager.bind("#toolbar #deselectall", "click", () -> myCanvas.selection.deselectAll()

    E.manager.bind "#toolbar #togglegrid",  "click", () -> if myCanvas.gridShow then myCanvas.hideGrid() else myCanvas.showGrid()
    E.manager.bind "#toolbar #zoomin",      "click", () -> myCanvas.zoomIn()
    E.manager.bind "#toolbar #zoomout",     "click", () -> myCanvas.zoomOut()
    E.manager.bind "#toolbar #zoomreset",   "click", () -> myCanvas.zoomReset()

  # E.manager.bind("#toolbar #save",        "click", () -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(myCanvas.model))
  # E.manager.bind("#toolbar #load",        "click", () -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

