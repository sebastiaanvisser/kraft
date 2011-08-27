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
Qualified "style.Color"
Qualified "style.Gradient"
Qualified "adjustable.Document",   As "DocumentA"
Qualified "adjustable.Line",       As "LineA"
Qualified "adjustable.Rect",       As "RectA"
Qualified "adjustable.Text",       As "TextA"
Qualified "adjustable.Triangle",   As "TriangleA"
Qualified "constraint.Constraint", As "C"
Qualified "visible.Document",      As "DocumentV"
Qualified "visible.Ellipse",       As "EllipseV"
Qualified "visible.Line",          As "LineV"
Qualified "visible.Pointer",       As "PointerV"
Qualified "visible.Rect",          As "RectV"
Qualified "visible.Shape",         As "ShapeV"
Qualified "visible.Text",          As "TextV"
Qualified "visible.Triangle",      As "TriangleV"

Register "Obj"
Class

  Main: ->
    @setupCanvas()
    @setupRootContainer()
    @setupDocument()
    @setupMenu()
    @setupGuides()
    # @playground()
    @

  playground: ->
    window.pt   = mk Point, 10, 20
    window.rect = mk Rect, 100, 200, 400, 600

  setupCanvas: ->
    @define canvas: mk Canvas, $("#mycanvas")[0]

  setupRootContainer: ->
    @define root: mk Container
    @root.decorate RenderContext, @canvas, @canvas.renderer, @canvas.elem

  setupDocument: ->
    @define document: mk Rect, 30, 20, 1030, 720
    @document.decorate ShapeV, @root
    @document.decorate DocumentV
    @document.decorate SelectableShape, @root.selection
    @document.decorate DocumentA
    @document.elem.id = "infovis"
    ($ @document.elem).addClass "mydocument"
    ($ @document.elem).addClass "shape"

  setupGuides: ->
    @define vguide: mk VerticalGuide,   @root, 630
    @define hguide: mk HorizontalGuide, @root, 420

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
    Events.manager.bind "#menu #debug1",      "click", => @debug0()
    Events.manager.bind "#menu #debug0",      "click", => @debug1()
    # Events.manager.bind("#menu #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(@canvas))
    # Events.manager.bind("#menu #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

  debug0: ->
    window.DEBUG = true
    __tools_Grapher().graph main.document.p0.$.y

  debug1: ->
    window.DEBUG = true

    g = mk Gradient
    g.ramp.push [0.0, mk Color, "#ffbb00"]
    g.ramp.push [0.1, mk Color, "#0000ff"]
    g.ramp.push [0.4, mk Color, "#ffffff"]
    g.ramp.push [0.5, mk Color, "#ffff44"]
    g.ramp.push [0.9, mk Color, "#ffbb00"]
    g.ramp.push [1.0, mk Color, "#0000ff"]
    window.gradient = g

  mkRect: (ctx) ->
    r = mk Rect, 130, 120, 230, 320
    r.decorate ShapeV, ctx
    r.decorate RectV
    r.decorate SelectableShape
    r.decorate RectA
    r.decorate MoveableShape
    ctx.addShape r
    $(r.elem).addClass "myrect"
    # r.container = Container.mk r
    # r.container.decorate RenderContext
    # @target = r.container
    window.rect = r

  mkEllipse: (ctx) ->
    e = mk Rect, 230, 120, 330, 320
    e.decorate ShapeV, ctx
    e.decorate EllipseV
    e.decorate SelectableShape
    e.decorate RectA
    e.decorate MoveableShape
    ctx.addShape e
    $(e.elem).addClass "myellipse"

  mkLine: (ctx) ->
    l = mk Line, 150, 200, 250, 200
    l.decorate ShapeV, ctx
    l.decorate LineV, 4
    l.decorate SelectableShape
    l.decorate LineA
    l.decorate MoveableShape
    ctx.addShape l
    $(l.elem).addClass "myline"

  mkText: (ctx, text) ->
    t = mk Line, 150, 200, 250, 200
    t.decorate Text, text
    t.decorate ShapeV, ctx
    t.decorate TextV
    t.decorate SelectableShape
    t.decorate TextA
    t.decorate MoveableShape
    ctx.addShape t
    $(t.elem).addClass "mytext"
    t

  mkPointer: (ctx) ->
    t = mk Line, 150, 200, 250, 200
    t.decorate ShapeV, ctx
    t.decorate PointerV
    t.decorate SelectableShape
    t.decorate LineA
    t.decorate MoveableShape
    ctx.addShape t
    $(t.elem).addClass "mypointer"
    t

###

  mkTriangle: (ctx) ->
    t = Triangle.mk ctx, 100, 100, 200, 200
    t.decorate TriangleV
    t.decorate SelectableShape
    t.decorate TriangleA
    t.decorate MoveableShape
    ctx.addShape t
    $(t.elem).addClass "mytriangle"
    $(t.elem).addClass "shape"

###

Static

  init: -> Events.manager.documentReady startup

  startup: -> window.main = mk Main

