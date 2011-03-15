Module "shape.AdjustableText"

Import "base.Obj"
Import "shape.DraggableShape"
Import "shape.Handle"
Import "shape.Line"
Import "shape.Point"
Import "shape.RenderableLine"
Qualified "constraint.Point", "Pc"
Qualified "Events", "E"

Class

  AdjustableText: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

    E.manager.bind @elem, "DOMCharacterDataModified",
      ((e) => @model.canvas.renderer.enqueue @)

  mkHandles: ->
    $(@elem).attr "contentEditable", true

    @handles = new Obj
    @handles.define "topLeft",     (Handle.make @model, @p0)
    @handles.define "bottomRight", (Handle.make @model, @p1)
    @handles.define "center",      (Handle.make @model, @center)

    @handles.define "spine",       (Line.make Point.make(), Point.make(), 2)
    sp = @handles.spine
    sp.decorate RenderableLine, @model
    sp.decorate DraggableShape
    $(sp.elem).addClass "text-spine"
    $(sp.elem).addClass "shape"
    Pc.eq sp.p0, @p0
    Pc.eq sp.p1, @p1

  delHandles: ->
    $(@elem).attr "contentEditable", false
    @handles.destructor()

Static init: -> Obj.register AdjustableText

