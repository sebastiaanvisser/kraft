Module "ui.Main"

# Import "shape.Text"
# Import "shape.Triangle"
Import "Canvas"
Import "shape.AdjustableDocument"
Import "shape.AdjustableLine"
Import "shape.AdjustableRect"
Import "shape.AdjustableText"
Import "shape.DraggableShape"
Import "shape.Line"
Import "shape.Point"
Import "shape.Rect"
Import "shape.RenderableDocument"
Import "shape.RenderableEllipse"
Import "shape.RenderableLine"
Import "shape.RenderableRect"
Import "shape.RenderableText"
Import "shape.SelectableShape"
Import "shape.Text"
Import "Units"
Qualified "Events", "E"

Static

  mkRect: (canvas) ->
    r = Rect.make 200, 100, 300, 300
    r.decorate RenderableRect, canvas.model
    r.decorate SelectableShape
    r.decorate AdjustableRect
    r.decorate DraggableShape
    canvas.model.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"

  mkDocument: (canvas) ->
    window.d = Rect.make 20, 20, 1020, 620
    d.decorate RenderableDocument, canvas.model
    d.decorate SelectableShape
    d.decorate AdjustableDocument
    canvas.model.addShape d
    $(d.elem).addClass "mydocument"
    $(d.elem).addClass "shape"
    d.topLeft.onchange () -> ($ ".grid").css "-webkit-mask-position", px @x + ' ' + px @y

  mkEllipse: (canvas) ->
    e = Rect.make 200, 100, 300, 300
    e.decorate RenderableEllipse, canvas.model
    e.decorate SelectableShape
    e.decorate AdjustableRect
    e.decorate DraggableShape
    canvas.model.addShape e
    $(e.elem).addClass "myellipse"
    $(e.elem).addClass "shape"

  mkText: (canvas, text) ->
    t = Text.make 100, 100, 400, 100, text
    t.decorate RenderableText, canvas.model
    t.decorate SelectableShape
    t.decorate AdjustableText
    t.decorate DraggableShape
    canvas.model.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"

  mkLine: (canvas) ->
    l = Line.make (Point.make 150, 200)
                , (Point.make 250, 200)
                , 20
    l.decorate RenderableLine, canvas.model
    l.decorate SelectableShape
    l.decorate AdjustableLine
    l.decorate DraggableShape
    canvas.model.addShape l
    $(l.elem).addClass "myline"
    $(l.elem).addClass "shape"

#  function mkTriangle (canvas)
#  {
#    var shp = AdjustableTriangle.make(canvas.model, 100, 100, 200, 200)
#    shp.decorate(DraggableShape)
#    canvas.model.addShape(shp);
#    $(shp.elem).addClass("mytriangle")
#    $(shp.elem).addClass("shape")
#    return shp
#  },

  init: ->
    window.myCanvas = Canvas.make $("#mycanvas")[0]

    mkDocument myCanvas

    E.manager.bind "#toolbar #rect",        "click", -> mkRect myCanvas
    E.manager.bind "#toolbar #line",        "click", -> mkLine myCanvas
    E.manager.bind "#toolbar #triangle",    "click", -> mkTriangle myCanvas
    E.manager.bind "#toolbar #ellipse",     "click", -> mkEllipse myCanvas
    E.manager.bind "#toolbar #text",        "click", -> mkText myCanvas, prompt() || "..."
    E.manager.bind "#toolbar #selectall",   "click", -> myCanvas.selection.selectAll()
    E.manager.bind "#toolbar #deselectall", "click", -> myCanvas.selection.deselectAll()
    E.manager.bind "#toolbar #togglegrid",  "click", -> if myCanvas.gridShow then myCanvas.hideGrid() else myCanvas.showGrid()
    E.manager.bind "#toolbar #zoomin",      "click", -> myCanvas.zoomIn()
    E.manager.bind "#toolbar #zoomout",     "click", -> myCanvas.zoomOut()
    E.manager.bind "#toolbar #zoomreset",   "click", -> myCanvas.zoomReset()
    # E.manager.bind("#toolbar #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(myCanvas.model))
    # E.manager.bind("#toolbar #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

