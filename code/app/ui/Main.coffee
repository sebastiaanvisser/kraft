Module "ui.Main"

# Import "adjustable.AdjustableLine"
# Import "adjustable.AdjustableText"
# Import "adjustable.AdjustableTriangle"
# Import "base.List"
# Import "handle.HorizontalGuide"
# Import "handle.VerticalGuide"
# Import "shape.Line"
# Import "shape.Point"
# Import "shape.Rect"
# Import "shape.Text"
# Import "shape.Triangle"
# Import "style.Color"
# Import "style.Gradient"
# Import "visible.VisibleLine"
# Import "visible.VisibleText"
# Import "visible.VisibleTriangle"
Import "Canvas"
Import "Units"
Import "adjustable.AdjustableDocument"
Import "adjustable.AdjustableRect"
Import "adjustable.MoveableShape"
Import "adjustable.SelectableShape"
Import "base.Obj"
Import "base.Value"
Import "shape.Container"
Import "shape.Point"
Import "shape.Rect"
Import "visible.VisibleContainer"
Import "visible.VisibleDocument"
Import "visible.VisibleEllipse"
Import "visible.VisibleRect"
Qualified "Events", "E"
Qualified "constraint.Constraint", "C"

Class

  Main: ->
    @setupCanvas()
    @setupRootContainer()
    @setupDocument()
    @setupMenu()
    # @setupGuides()
    @playground()
    @

  playground: ->
    window.pt = mk Point, 10, 20
    window.rect = mk Rect, 100, 200, 400, 600

  setupCanvas: ->
    @canvas = mk Canvas, $("#mycanvas")[0]

  setupRootContainer: ->
    @root = mk Container, @canvas
    @root.decorate VisibleContainer, @canvas, @canvas.renderer, @canvas.elem

  setupDocument: ->
    @document = mk Rect, 30, 20, 230, 520
    @document.decorate VisibleDocument, @canvas, @canvas.renderer, @canvas.elem
    @document.decorate SelectableShape, @root.selection
    @document.decorate AdjustableDocument
    ($ @document.elem).addClass "mydocument"
    ($ @document.elem).addClass "shape"
    @document

  mkRect: (parent) ->
    r = mk Rect, 130, 120, 230, 320
    r.decorate VisibleRect, @canvas, @canvas.renderer, @canvas.elem
    r.decorate SelectableShape, @root.selection
    r.decorate AdjustableRect
    r.decorate MoveableShape
    parent.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"
    # r.container = Container.mk r
    # r.container.decorate VisibleContainer
    # @target = r.container
    r

  mkEllipse: (parent) ->
    e = mk Rect, 230, 120, 330, 320
    e.decorate VisibleEllipse, @canvas, @canvas.renderer, @canvas.elem
    e.decorate SelectableShape, @root.selection
    e.decorate AdjustableRect
    e.decorate MoveableShape
    parent.addShape e
    $(e.elem).addClass "myellipse"
    $(e.elem).addClass "shape"

  setupMenu: ->
    E.manager.bind "#menu #rect",        "click", => @mkRect @root
    E.manager.bind "#menu #line",        "click", => @mkLine @root
    E.manager.bind "#menu #triangle",    "click", => @mkTriangle @root
    E.manager.bind "#menu #ellipse",     "click", => @mkEllipse @root
    E.manager.bind "#menu #text",        "click", => @mkText @root, prompt() || "..."
    E.manager.bind "#menu #selectall",   "click", => @root.selection.selectAll()
    E.manager.bind "#menu #deselectall", "click", => @root.selection.deselectAll()
    E.manager.bind "#menu #togglegrid",  "click", => @canvas.gridShow = !@canvas.gridShow
    E.manager.bind "#menu #zoomin",      "click", => @canvas.zoom *= 2
    E.manager.bind "#menu #zoomout",     "click", => @canvas.zoom /= 2
    E.manager.bind "#menu #zoomreset",   "click", => @canvas.zoom = 1
    # E.manager.bind("#menu #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(@canvas))
    # E.manager.bind("#menu #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

Static

  init: -> # E.manager.documentReady startup
    startup()

  startup: ->
    main = new Main()
    window.main = main

###

  setupGuides: ->
    @hguide = VerticalGuide.mk   @root, 630
    @vguide = HorizontalGuide.mk @root, 420

  mkText: (parent, text) ->
    t = Text.mk parent, 30, 70, 130, 70, text
    t.decorate VisibleText
    t.decorate SelectableShape
    t.decorate AdjustableText
    t.decorate MoveableShape
    parent.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"
    t

  mkLine: (parent) ->
    l = Line.mk parent, (Point.mk parent, 150, 200), (Point.mk parent, 250, 200), 20
    l.decorate VisibleLine
    l.decorate SelectableShape
    l.decorate AdjustableLine
    l.decorate MoveableShape
    parent.addShape l
    $(l.elem).addClass "myline"
    $(l.elem).addClass "shape"

  mkTriangle: (parent) ->
    t = Triangle.mk parent, 100, 100, 200, 200
    t.decorate VisibleTriangle
    t.decorate SelectableShape
    t.decorate AdjustableTriangle
    t.decorate MoveableShape
    parent.addShape t
    ($ t.elem).addClass "mytriangle"
    ($ t.elem).addClass "shape"

###

