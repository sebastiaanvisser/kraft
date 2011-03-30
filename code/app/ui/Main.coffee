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
Import "base.Obj"
Import "base.Value"
Import "handle.HorizontalGuide"
Import "handle.VerticalGuide"
Import "shape.Container"
Import "shape.Line"
Import "shape.Point"
Import "shape.Rect"
Import "shape.Text"
Import "shape.Triangle"
Import "visible.RenderContext"
Import "visible.VisibleDocument"
Import "visible.VisibleEllipse"
Import "visible.VisibleLine"
Import "visible.VisibleRect"
Import "visible.VisibleShape"
Import "visible.VisibleText"
Import "visible.VisibleTriangle"
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
    window.pt   = mk Point, 10, 20
    window.rect = mk Rect, 100, 200, 400, 600

  setupCanvas: ->
    @canvas = mk Canvas, $("#mycanvas")[0]

  setupRootContainer: ->
    @root = mk Container, @canvas
    @root.decorate RenderContext, @canvas, @canvas.renderer, @canvas.elem

  setupDocument: ->
    @document = mk Rect, 30, 20, 230, 520
    @document.decorate VisibleShape, @root
    @document.decorate VisibleDocument
    @document.decorate SelectableShape, @root.selection
    @document.decorate AdjustableDocument
    ($ @document.elem).addClass "mydocument"
    ($ @document.elem).addClass "shape"
    @document

  setupGuides: ->
    @hguide = mk VerticalGuide,   @root, 630
    @vguide = mk HorizontalGuide, @root, 420

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

  mkRect: (parent) ->
    r = mk Rect, 130, 120, 230, 320
    r.decorate VisibleShape, @root
    r.decorate VisibleRect
    r.decorate SelectableShape, @root.selection
    r.decorate AdjustableRect
    r.decorate MoveableShape
    parent.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"
    # r.container = Container.mk r
    # r.container.decorate RenderContext
    # @target = r.container
    r

  mkEllipse: (parent) ->
    e = mk Rect, 230, 120, 330, 320
    e.decorate VisibleShape, @root
    e.decorate VisibleEllipse
    e.decorate SelectableShape, @root.selection
    e.decorate AdjustableRect
    e.decorate MoveableShape
    parent.addShape e
    $(e.elem).addClass "myellipse"
    $(e.elem).addClass "shape"

  mkLine: (parent) ->
    l = mk Line, (mk Point, 150, 200), (mk Point, 250, 200)
    l.decorate VisibleShape, @root
    l.decorate VisibleLine
    l.decorate SelectableShape, @root.selection
    l.decorate AdjustableLine
    l.decorate MoveableShape
    parent.addShape l
    $(l.elem).addClass "myline"
    $(l.elem).addClass "shape"

  mkText: (parent, text) ->
    t = mk Line, (mk Point, 150, 200), (mk Point, 250, 200)
    t = t.decorate Text, text
    t.decorate VisibleShape, @root
    t.decorate VisibleText
    t.decorate SelectableShape, @root.selection
    t.decorate AdjustableText
    t.decorate MoveableShape
    parent.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"
    t

###

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

Static

  init: -> E.manager.documentReady startup

  startup: -> window.main = new Main()

