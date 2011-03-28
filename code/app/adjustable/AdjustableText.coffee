Module "adjustable.AdjustableText"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "handle.Handle"
Import "shape.Line"
Import "shape.Point"
Import "visible.VisibleLine"
Qualified "Events", "E"
Qualified "constraint.Point", "Pc"

Register "Obj"
Class

  AdjustableText: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

    E.manager.bind @elem, "DOMCharacterDataModified", (e) =>
      @text = @elem.innerHTML
      @renderer.enqueue @
      return true

  mkHandles: ->
    ($ @elem).attr "contentEditable", true

    @derive handles: new Obj
    @handles.define
      topLeft:      mk Handle, @p0,     @canvas, @renderer, @parentElem
      bottomRight:  mk Handle, @p1,     @canvas, @renderer, @parentElem
      center:       mk Handle, @center, @canvas, @renderer, @parentElem

    # @handles.define "spine", (Line.make @parent, (Point.make @parent), (Point.make @parent), 2)
    # sp = @handles.spine
    # sp.decorate VisibleLine, @parent
    # sp.decorate MoveableShape
    # $(sp.elem).addClass "text-spine"
    # $(sp.elem).addClass "shape"
    # Pc.eq sp.p0, @p0
    # Pc.eq sp.p1, @p1

  delHandles: ->
    ($ @elem).attr "contentEditable", false
    @handles.destructor()

