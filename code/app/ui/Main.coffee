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

Qualified "constraint.Constraint", "C"
Import "base.List"
Import "style.Color"
Import "style.Gradient"

Class

  Main: ->
    @setupCanvas()
    @setupRootContainer()
    @setupDocument()
    @setupMenu()
    @setupGuides()
    @playground()
    @

  playground: ->
    window.myGradient = Gradient.make()
    d = @document
    myGradient.onchange -> ($ d.elem).css "background", @webkit
    myGradient.ramp.push [0.0, Color.make "#fff"]
    myGradient.ramp.push [0.5, Color.make "#fc0"]
    myGradient.ramp.push [0.6, Color.make "#444"]
    myGradient.ramp.push [0.9, Color.make "#000"]
    myGradient.ramp.push [1.0, Color.make "#00f"]
    myGradient.ramp.push [1.0, Color.make "#00f"]

  setupCanvas: ->
    @canvas = Canvas.make $("#mycanvas")[0]

  setupRootContainer: ->
    @root = Container.make @canvas
    @root.decorate VisibleContainer
    @target = @root

  setupDocument: ->
    @document = Rect.make @root, 30, 20, 730, 520
    @document.decorate VisibleDocument
    @document.decorate SelectableShape
    @document.decorate AdjustableDocument
    ($ @document.elem).addClass "mydocument"
    ($ @document.elem).addClass "shape"
    @document

  setupGuides: ->
    @hguide = VerticalGuide.make   @root, 630
    @vguide = HorizontalGuide.make @root, 420

  setupMenu: ->
    E.manager.bind "#menu #rect",        "click", => @mkRect @target
    E.manager.bind "#menu #line",        "click", => @mkLine @target
    E.manager.bind "#menu #triangle",    "click", => @mkTriangle @target
    E.manager.bind "#menu #ellipse",     "click", => @mkEllipse @target
    E.manager.bind "#menu #text",        "click", => @mkText @target, prompt() || "..."
    E.manager.bind "#menu #selectall",   "click", => @target.selection.selectAll()
    E.manager.bind "#menu #deselectall", "click", => @target.selection.deselectAll()
    E.manager.bind "#menu #togglegrid",  "click", => @canvas.gridShow = !@canvas.gridShow
    E.manager.bind "#menu #zoomin",      "click", => @canvas.zoom *= 2
    E.manager.bind "#menu #zoomout",     "click", => @canvas.zoom /= 2
    E.manager.bind "#menu #zoomreset",   "click", => @canvas.zoom = 1
    # E.manager.bind("#menu #save",        "click", -> IO.save("mymodel.xml", "Saved document: mymodel", Serializer.toXml(@canvas))
    # E.manager.bind("#menu #load",        "click", -> IO.load "mymodel.xml", (x) -> Deserializer.baseFromXml x.documentElement

  mkRect: (parent) ->
    r = Rect.make parent, 130, 120, 230, 320
    r.decorate VisibleRect
    r.decorate SelectableShape
    r.decorate AdjustableRect
    r.decorate MoveableShape
    parent.addShape r
    $(r.elem).addClass "myrect"
    $(r.elem).addClass "shape"

    r.container = Container.make r
    r.container.decorate VisibleContainer
    # @target = r.container

    r

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
    t = Text.make parent, 30, 70, 130, 70, text
    t.decorate VisibleText
    t.decorate SelectableShape
    t.decorate AdjustableText
    t.decorate MoveableShape
    parent.addShape t
    $(t.elem).addClass "mytext"
    $(t.elem).addClass "shape"
    t

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

