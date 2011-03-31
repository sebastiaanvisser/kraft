Module "ui.Main"

Import "Canvas"
Import "RenderContext"
Import "Units"
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
Qualified "Events"
Qualified "adjustable.Document",   As "AdjustableDocument"
Qualified "adjustable.Line",       As "AdjustableLine"
Qualified "adjustable.Rect",       As "AdjustableRect"
Qualified "adjustable.Text",       As "AdjustableText"
Qualified "adjustable.Triangle",   As "AdjustableTriangle"
Qualified "constraint.Constraint", As "C"
Qualified "visible.Document",      As "VisibleDocument"
Qualified "visible.Ellipse",       As "VisibleEllipse"
Qualified "visible.Line",          As "VisibleLine"
Qualified "visible.Pointer",       As "VisiblePointer"
Qualified "visible.Rect",          As "VisibleRect"
Qualified "visible.Shape",         As "VisibleShape"
Qualified "visible.Text",          As "VisibleText"
Qualified "visible.Triangle",      As "VisibleTriangle"

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
    Events.manager.bind "#menu #rect",        "click", => @mkRect @root
    Events.manager.bind "#menu #line",        "click", => @mkLine @root
    Events.manager.bind "#menu #triangle",    "click", => @mkTriangle @root
    Events.manager.bind "#menu #ellipse",     "click", => @mkEllipse @root
    Events.manager.bind "#menu #text",        "click", => @mkText @root, prompt() || "..."
    Events.manager.bind "#menu #pointer",     "click", => @mkPointer @root
    Events.manager.bind "#menu #selectall",   "click", => @root.selection.selectAll()
    Events.manager.bind "#menu #deselectall", "click", => @root.selection.deselectAll()
    Events.manager.bind "#menu #togglegrid",  "click", => @canvas.gridShow = !@canvas.gridShow
    Events.manager.bind "#menu #zoomin",      "click", => @canvas.zoom *= 2
    Events.manager.bind "#menu #zoomout",     "click", => @canvas.zoom /= 2
    Events.manager.bind "#menu #zoomreset",   "click", => @canvas.zoom = 1
    # Events.manager.bind("#menu #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(@canvas))
    # Events.manager.bind("#menu #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

  mkRect: (ctx) ->
    r = mk Rect, 130, 120, 230, 320
    r.decorate VisibleShape, @root
    r.decorate VisibleRect
    r.decorate SelectableShape, @root.selection
    r.decorate AdjustableRect
    r.decorate MoveableShape
    ctx.addShape r
    $(r.elem).addClass "myrect"
    # r.container = Container.mk r
    # r.container.decorate RenderContext
    # @target = r.container
    r

  mkEllipse: (ctx) ->
    e = mk Rect, 230, 120, 330, 320
    e.decorate VisibleShape, @root
    e.decorate VisibleEllipse
    e.decorate SelectableShape, @root.selection
    e.decorate AdjustableRect
    e.decorate MoveableShape
    ctx.addShape e
    $(e.elem).addClass "myellipse"

  mkLine: (ctx) ->
    l = mk Line, (mk Point, 150, 200), (mk Point, 250, 200)
    l.decorate VisibleShape, @root
    l.decorate VisibleLine
    l.decorate SelectableShape, @root.selection
    l.decorate AdjustableLine
    l.decorate MoveableShape
    ctx.addShape l
    $(l.elem).addClass "myline"

  mkText: (ctx, text) ->
    t = mk Line, (mk Point, 150, 200), (mk Point, 250, 200)
    t = t.decorate Text, text
    t.decorate VisibleShape, @root
    t.decorate VisibleText
    t.decorate SelectableShape, @root.selection
    t.decorate AdjustableText
    t.decorate MoveableShape
    ctx.addShape t
    $(t.elem).addClass "mytext"
    t

  mkPointer: (ctx) ->
    t = mk Line, (mk Point, 150, 200), (mk Point, 250, 200)
    t.decorate VisibleShape, @root
    t.decorate VisiblePointer
    t.decorate SelectableShape, @root.selection
    t.decorate AdjustableLine
    t.decorate MoveableShape
    ctx.addShape t
    $(t.elem).addClass "mypointer"
    t

###

  mkTriangle: (ctx) ->
    t = Triangle.mk ctx, 100, 100, 200, 200
    t.decorate VisibleTriangle
    t.decorate SelectableShape
    t.decorate AdjustableTriangle
    t.decorate MoveableShape
    ctx.addShape t
    ($ t.elem).addClass "mytriangle"
    ($ t.elem).addClass "shape"

###

Static

  init: -> Events.manager.documentReady startup

  startup: -> window.main = new Main()

