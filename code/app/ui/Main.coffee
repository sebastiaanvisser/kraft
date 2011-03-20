Module "ui.Main"

Import "Canvas"
Import "Units"
Import "adjustable.AdjustableDocument"
Import "adjustable.AdjustableLine"
Import "adjustable.AdjustableRect"
Import "adjustable.AdjustableText"
Import "adjustable.AdjustableTriangle"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Import "handle.HorizontalGuide"
Import "handle.VerticalGuide"
Import "shape.Container"
Import "shape.Line"
Import "shape.Point"
Import "shape.Rect"
Import "shape.Text"
Import "shape.Triangle"
Import "visible.VisibleContainer"
Import "visible.VisibleDocument"
Import "visible.VisibleEllipse"
Import "visible.VisibleLine"
Import "visible.VisibleRect"
Import "visible.VisibleText"
Import "visible.VisibleTriangle"
Qualified "Events", "E"

Class

  Main: ->
    @setupCanvas()
    @setupRootContainer()
    @setupDocument()
    @setupMenu()
    @setupGuides()
    @

  setupCanvas: ->
    @canvas = Canvas.make $("#mycanvas")[0]

  setupRootContainer: ->
    @root = Container.make @canvas
    @root.decorate VisibleContainer

  setupDocument: ->
    @document = Rect.make @root, 20, 20, 720, 520
    @document.decorate VisibleDocument
    @document.decorate SelectableShape
    @document.decorate AdjustableDocument
    ($ @document.elem).addClass "mydocument"
    ($ @document.elem).addClass "shape"
    @document

  setupGuides: ->
    @hguide0 = HorizontalGuide.make @root, 10
    @vguide0 = VerticalGuide.make   @root, 10
    @vguide1 = HorizontalGuide.make @root, 530
    @hguide1 = VerticalGuide.make   @root, 730

  setupMenu: ->
    E.manager.bind "#toolbar #rect",        "click", => @mkRect @root
    E.manager.bind "#toolbar #line",        "click", => @mkLine @root
    E.manager.bind "#toolbar #triangle",    "click", => @mkTriangle @root
    E.manager.bind "#toolbar #ellipse",     "click", => @mkEllipse @root
    E.manager.bind "#toolbar #text",        "click", => @mkText @root, prompt() || "..."
    E.manager.bind "#toolbar #selectall",   "click", => @root.selection.selectAll()
    E.manager.bind "#toolbar #deselectall", "click", => @root.selection.deselectAll()
    E.manager.bind "#toolbar #togglegrid",  "click", => @canvas.gridShow = !@canvas.gridShow
    E.manager.bind "#toolbar #zoomin",      "click", => @canvas.zoom *= 2
    E.manager.bind "#toolbar #zoomout",     "click", => @canvas.zoom /= 2
    E.manager.bind "#toolbar #zoomreset",   "click", => @canvas.zoom = 1
    # E.manager.bind("#toolbar #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(@canvas))
    # E.manager.bind("#toolbar #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

  mkRect: (parent) ->
    r = Rect.make parent, 200, 100, 300, 300
    r.decorate VisibleRect
    r.decorate SelectableShape
    r.decorate AdjustableRect
    r.decorate MoveableShape
    parent.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"

  mkEllipse: (parent) ->
    e = Rect.make parent, 200, 100, 300, 300
    e.decorate VisibleEllipse
    e.decorate SelectableShape
    e.decorate AdjustableRect
    e.decorate MoveableShape
    parent.addShape e
    $(e.elem).addClass "myellipse"
    $(e.elem).addClass "shape"

  mkText: (parent, text) ->
    t = Text.make parent, 100, 100, 400, 100, text
    t.decorate VisibleText
    t.decorate SelectableShape
    t.decorate AdjustableText
    t.decorate MoveableShape
    parent.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"

  mkLine: (parent) ->
    l = Line.make parent, (Point.make parent, 150, 200), (Point.make parent, 250, 200), 20
    l.decorate VisibleLine
    l.decorate SelectableShape
    l.decorate AdjustableLine
    l.decorate MoveableShape
    parent.addShape l
    $(l.elem).addClass "myline"
    $(l.elem).addClass "shape"

  mkTriangle: (parent) ->
    t = Triangle.make parent, 100, 100, 200, 200
    t.decorate VisibleTriangle
    t.decorate SelectableShape
    t.decorate AdjustableTriangle
    t.decorate MoveableShape
    parent.addShape t
    ($ t.elem).addClass "mytriangle"
    ($ t.elem).addClass "shape"

Static

  init: -> E.manager.documentReady startup

  startup: ->
    main = new Main()
    window.main = main

