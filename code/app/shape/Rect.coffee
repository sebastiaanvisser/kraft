Module "shape.Rect"

Import "base.Obj"
Import "constraint.Constraint"
Qualified "constraint.Point", "Pc"
Qualified "shape.Point", "Pt"

Class

  Rect: (revive, _, x0, y0, x1, y1) ->
    unless revive
      @define "p0",     Pt.make x0, y0
      @define "p3",     Pt.make x1, y1
      @define "radius", 0
      @define "border", 5

    Pc.yx @derive("p1", Pt.make()).v, @p0, @p3
    Pc.xy @derive("p2", Pt.make()).v, @p0, @p3

    Pc.mid          @derive("center",      Pt.make()).v, @p0, @p3
    Pc.topLeft      @derive("topLeft",     Pt.make()).v, @p0, @p3
    Pc.topRight     @derive("topRight",    Pt.make()).v, @p0, @p3
    Pc.bottomLeft   @derive("bottomLeft",  Pt.make()).v, @p0, @p3
    Pc.bottomRight  @derive("bottomRight", Pt.make()).v, @p0, @p3
    Pc.xy           @derive("midLeft",     Pt.make()).v, @p0, @center
    Pc.xy           @derive("midRight",    Pt.make()).v, @p1, @center
    Pc.yx           @derive("midTop",      Pt.make()).v, @p0, @center
    Pc.yx           @derive("midBottom",   Pt.make()).v, @p2, @center

    sub0 @derive("width",  0), @bottomRight.$.x, @topLeft.$.x
    sub0 @derive("height", 0), @bottomRight.$.y, @topLeft.$.y
    min0 @derive("left",   0), @p0.$.x,          @p3.$.x
    min0 @derive("top",    0), @p0.$.y,          @p3.$.y
    max0 @derive("right",  0), @p0.$.x,          @p3.$.x
    max0 @derive("bottom", 0), @p0.$.y,          @p3.$.y
    @

Static

  init: () -> Obj.register Rect

  make: (x0, y0, x1, y1) ->
    (new Obj "Rect").decorate Rect, null, x0, y0, x1, y1

# -----------------------------------------------------------------------------

Module "shape.RenderableRect"

Import "base.Obj"

Class

  RenderableRect: (revive, model) ->
    @model    = model
    @elem     = @setupElem()

    @onchange -> @model.canvas.renderer.enqueue @
    @render()
    @

  setupElem: () ->
    elem = document.createElement "div"
    $(elem).addClass "rect"
    elem.style.position = "absolute"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: () ->
    @unrender()

  render: () ->
    @elem.style.left   = @left   + "px"
    @elem.style.top    = @top    + "px"
    @elem.style.width  = @width  + "px"
    @elem.style.height = @height + "px"

    r = (if @radius >= 0 then @radius else Math.round(-@radius / 5)) + "px"
    @elem.style.borderTopLeftRadius     =
    @elem.style.borderTopRightRadius    =
    @elem.style.borderBottomLeftRadius  =
    @elem.style.borderBottomRightRadius = r

    b = (if @border >= 0 then @border else Math.round(-@border / 5)) + "px"
    @elem.style.borderWidth = b

  unrender: () ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: () -> Obj.register RenderableRect

# -----------------------------------------------------------------------------

Module "shape.AdjustableRect"

Import "base.Obj"
Import "base.Value"
Import "constraint.Constraint"
Import "shape.Handle"
Import "shape.HorizontalHandle"
Import "shape.VerticalHandle"
Qualified "shape.Point", "Pt"

Class

  AdjustableRect: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

  mkHandles: ->
    @define "handles", new Obj("Handles", @)
    @handles.define "topLeft",     (Handle.make           @model, @p0)
    @handles.define "topRight",    (Handle.make           @model, @p1)
    @handles.define "bottomLeft",  (Handle.make           @model, @p2)
    @handles.define "bottomRight", (Handle.make           @model, @p3)
    @handles.define "midLeft",     (HorizontalHandle.make @model, @midLeft)
    @handles.define "midRight",    (HorizontalHandle.make @model, @midRight)
    @handles.define "midTop",      (VerticalHandle.make   @model, @midTop)
    @handles.define "midBottom",   (VerticalHandle.make   @model, @midBottom)
    @handles.define "center",      (Handle.make           @model, @center)

    radiusH = Pt.make()
    add0 radiusH.$.y, @topLeft.$.y, val 10
    add0 radiusH.$.x, @$.radius, @topLeft.$.x
    @handles.define "radiusH", (HorizontalHandle.make @model, radiusH)

    borderH = Pt.make()
    add0 borderH.$.x, @$.border, @topLeft.$.x
    add0 borderH.$.y, @midLeft.$.y, val 10
    @handles.define "borderH", (HorizontalHandle.make @model, borderH)

  delHandles: ->
    @handles.destructor()

Static

  init: ->
    Obj.register AdjustableRect

