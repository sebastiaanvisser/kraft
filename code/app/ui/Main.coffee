Module "ui.Main"

Import "Canvas"
Import "Container"
Import "Units"
Import "VisibleContainer"
Import "shape.AdjustableDocument"
Import "shape.AdjustableLine"
Import "shape.AdjustableRect"
Import "shape.AdjustableText"
Import "shape.AdjustableTriangle"
Import "shape.DraggableShape"
Import "shape.Line"
Import "shape.Point"
Import "shape.Rect"
Import "shape.RenderableDocument"
Import "shape.RenderableEllipse"
Import "shape.RenderableLine"
Import "shape.RenderableRect"
Import "shape.RenderableText"
Import "shape.RenderableTriangle"
Import "shape.SelectableShape"
Import "shape.Text"
Import "shape.Triangle"
Qualified "Events", "E"

Static

  mkRect: (parent) ->
    r = Rect.make parent, 200, 100, 300, 300
    r.decorate RenderableRect
    r.decorate SelectableShape
    r.decorate AdjustableRect
    r.decorate DraggableShape
    parent.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"

  mkEllipse: (parent) ->
    e = Rect.make parent, 200, 100, 300, 300
    e.decorate RenderableEllipse
    e.decorate SelectableShape
    e.decorate AdjustableRect
    e.decorate DraggableShape
    parent.addShape e
    $(e.elem).addClass "myellipse"
    $(e.elem).addClass "shape"

  mkText: (parent, text) ->
    t = Text.make parent, 100, 100, 400, 100, text
    t.decorate RenderableText
    t.decorate SelectableShape
    t.decorate AdjustableText
    t.decorate DraggableShape
    parent.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"

  mkLine: (parent) ->
    l = Line.make parent, (Point.make parent, 150, 200), (Point.make parent, 250, 200), 20
    l.decorate RenderableLine
    l.decorate SelectableShape
    l.decorate AdjustableLine
    l.decorate DraggableShape
    parent.addShape l
    $(l.elem).addClass "myline"
    $(l.elem).addClass "shape"

  mkTriangle: (parent) ->
    t = Triangle.make parent, 100, 100, 200, 200
    t.decorate RenderableTriangle
    t.decorate SelectableShape
    t.decorate AdjustableTriangle
    t.decorate DraggableShape
    parent.addShape t
    ($ t.elem).addClass "mytriangle"
    ($ t.elem).addClass "shape"

  init: -> E.manager.documentReady startup

  startup: ->
    canvas = Canvas.make $("#mycanvas")[0]

    root = Container.make canvas
    root.decorate VisibleContainer

    doc = Rect.make root, 20, 20, 620, 520
    doc.decorate RenderableDocument
    doc.decorate SelectableShape
    doc.decorate AdjustableDocument
    ($ doc.elem).addClass "mydocument"
    ($ doc.elem).addClass "shape"
    doc.topLeft.onchange () -> ($ ".grid").css "-webkit-mask-position", (px @x) + ' ' + (px @y)

    # For now, make top level canvas globally available.
    window.canvas = canvas

    E.manager.bind "#toolbar #rect",        "click", -> mkRect root
    E.manager.bind "#toolbar #line",        "click", -> mkLine root
    E.manager.bind "#toolbar #triangle",    "click", -> mkTriangle root
    E.manager.bind "#toolbar #ellipse",     "click", -> mkEllipse root
    E.manager.bind "#toolbar #text",        "click", -> mkText root, prompt() || "..."

    E.manager.bind "#toolbar #selectall",   "click", -> root.selection.selectAll()
    E.manager.bind "#toolbar #deselectall", "click", -> root.selection.deselectAll()

    E.manager.bind "#toolbar #togglegrid",  "click", -> if canvas.gridShow then canvas.hideGrid() else canvas.showGrid()
    E.manager.bind "#toolbar #zoomin",      "click", -> canvas.zoomIn()
    E.manager.bind "#toolbar #zoomout",     "click", -> canvas.zoomOut()
    E.manager.bind "#toolbar #zoomreset",   "click", -> canvas.zoomReset()

    # E.manager.bind("#toolbar #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(canvas))
    # E.manager.bind("#toolbar #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

