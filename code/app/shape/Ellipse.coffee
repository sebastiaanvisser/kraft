Module "shape.RenderableEllipse"

Import "base.Obj"

Class

  RenderableEllipse: (revive, model) ->
    @model  = model
    @elem   = @setupElem()

    @onchange => @model.canvas.renderer.enqueue @
    @render()
    @

  setupElem: ->
    elem = document.createElement "div"
    $(elem).addClass "ellipse"
    @model.canvas.canvasElem.appendChild elem
    elem

  destructor: -> @unrender()

  render: ->
    w = @right  - @left
    h = @bottom - @top

    @elem.style.left   = @left + "px"
    @elem.style.top    = @top  + "px"
    @elem.style.width  = w     + "px"
    @elem.style.height = h     + "px"

    @elem.style.borderTopLeftRadius     =
    @elem.style.borderTopRightRadius    =
    @elem.style.borderBottomLeftRadius  =
    @elem.style.borderBottomRightRadius = @width/2 + "px " + @height/2 + "px "

  unrender: ->
    @model.canvas.canvasElem.removeChild @elem

Static

  init: -> Obj.register RenderableEllipse

