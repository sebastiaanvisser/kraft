Module "adjustable.Text"

Import "adjustable.MoveableShape"
Import "base.Obj"
Import "handle.Handle"
Import "shape.Line"
Import "shape.Point"
Qualified "Events", As "E"
Qualified "constraint.Point", As "Pc"
Qualified "visible.Line", As "VisibleLine"

Register "Obj"
Class

  Text: ->
    @onselect.push   => @mkHandles()
    @ondeselect.push => @delHandles()
    @

    E.manager.bind @elem, "DOMCharacterDataModified", (e) =>
      @text = @elem.innerHTML
      @renderContext.renderer.enqueue @
      return true

  mkHandles: ->
    ($ @elem).attr "contentEditable", true

    @derive handles: new Obj
    @handles.define
      topLeft:      mk Handle, @p0,     @renderContext
      bottomRight:  mk Handle, @p1,     @renderContext
      center:       mk Handle, @center, @renderContext

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
    delete @handles

