Module "shape.Line"

Import "base.Obj"
Qualified "constraint.Point", "Pc"
Qualified "constraint.Constraint", "C"
Qualified "shape.Point", "Pt"

Class

  Line: (revive, _, x0, y0, x1, y1, w) ->
    unless revive
      @define "p0", Pt.make(x0, y0)
      @define "p1", Pt.make(x1, y1)
      @define "width", w

    Pc.mid          @derive("center",      Pt.make()).v, @p0, @p1
    Pc.topLeft      @derive("topLeft",     Pt.make()).v, @p0, @p1
    Pc.bottomRight  @derive("bottomRight", Pt.make()).v, @p0, @p1
    
    C.min0 @define("left",   0), @p0.$.x, @p1.$.x
    C.min0 @define("top",    0), @p0.$.y, @p1.$.y
    C.max0 @define("right",  0), @p0.$.x, @p1.$.x
    C.max0 @define("bottom", 0), @p0.$.y, @p1.$.y
    @

Static

  init: -> Obj.register Line

  make: (x0, y0, x1, y1, w) ->
    (new Obj).decorate Line, null, x0, y0, x1, y1, w

Module "shape.RenderableLine"

Import "base.Obj"
Import "shape.Line"

Class

  RenderableLine: (revive, model) ->
    @model  = model
    @canvas = @model.canvas
    @elem   = @setupElem()

    @onchange => @canvas.renderer.enqueue @
    @render()
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "line"
    elem.style.position = "absolute"
    @canvas.canvasElem.appendChild elem
    elem

  destructor: ->
    @unrender()

  render: ->
    x0 = @p0.x
    y0 = @p0.y
    x1 = @p1.x
    y1 = @p1.y
    w  = @width
    len = Math.sqrt(Math.pow(x1 - x0, 2) + Math.pow(y1 - y0, 2))
    rot = Math.atan((y1 - y0) / (x1 - x0)) * 180 / Math.PI
    @elem.style.left   = ((x0 + x1 - len) / 2) + "px"
    @elem.style.top    = ((y0 + y1 - w)   / 2) + "px"
    @elem.style.width  = len                   + "px"
    @elem.style.height = w                     + "px"

    @elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"

  unrender: ->
    @canvas.canvasElem.removeChild @elem

Static

  init: ->
    Obj.register RenderableLine

  make: (canvas, x0, y0, x1, y1, w) ->
    (Line.make x0, y0, x1, y1, w).decorate RenderableLine, canvas

Module "shape.AdjustableLine"

Import "shape.Handle"
Import "shape.SelectableShape"
Import "shape.RenderableLine"
Import "base.Obj"

Class

  AdjustableLine: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @handles = new Obj
    @handles.define "topLeft",     Handle.make(@model, @p0)
    @handles.define "bottomRight", Handle.make(@model, @p1)
    @handles.define "center",      Handle.make(@model, @center)

  delHandles: -> @handles.destructor()

Static

  init: ->
    Obj.register AdjustableLine

  make: (model, x0, y0, x1, y1, w) ->
    (RenderableLine.make model, x0, y0, x1, y1, w).decorate(SelectableShape).decorate AdjustableLine

