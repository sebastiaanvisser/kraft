Module "shape.AdjustableText"

Import "base.Obj"
Import "shape.DraggableShape"
Import "shape.Handle"
Import "shape.Line"
Import "shape.Point"
Import "shape.VisibleLine"
Qualified "constraint.Point", "Pc"
Qualified "Events", "E"

Class

  AdjustableText: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

    E.manager.bind @elem, "DOMCharacterDataModified",
      ((e) => @renderer.enqueue @)

  mkHandles: ->
    $(@elem).attr "contentEditable", true

    @handles = new Obj
    @handles.define "topLeft",     (Handle.make @parent, @p0)
    @handles.define "bottomRight", (Handle.make @parent, @p1)
    @handles.define "center",      (Handle.make @parent, @center)

    @handles.define "spine", (Line.make @parent, (Point.make @parent), (Point.make @parent), 2)
    sp = @handles.spine
    sp.decorate VisibleLine, @parent
    sp.decorate DraggableShape
    $(sp.elem).addClass "text-spine"
    $(sp.elem).addClass "shape"
    Pc.eq sp.p0, @p0
    Pc.eq sp.p1, @p1

  delHandles: ->
    $(@elem).attr "contentEditable", false
    @handles.destructor()

Static init: -> Obj.register AdjustableText

