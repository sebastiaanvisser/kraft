Module("shape.Handle")

Import("base.Obj")
Import("shape.DraggableShape")
Import("shape.Rect")
Import("shape.RenderableEllipse")
Qualified("constraint.Point", "P")

Class
(

  function Handle (revive, model, pt)
  {
    this.model = model
    this.pt    = pt

    this.defHandlePoint("handle", RenderableEllipse, 0, 0, 10, 10)
  },

  function defHandlePoint (prop, type, x, y, w, h)
  {
    this.define(prop, Rect.make(x, y, w, h))
    this[prop].decorate(type, this.model)
    this[prop].decorate(DraggableShape)
    $(this[prop].elem).addClass(prop)
    P.eq(this[prop].center, this.pt)
  }

)

Static
(

  function init ()
  {
    Obj.register(Handle)
  },

  function make (model, pt)
  {
    var h = new Obj
    h.decorate(Handle, model, pt)
    return h
  }

)

Module("shape.VerticalHandle")

Import("shape.Handle")
Import("shape.RenderableRect")

Class
(

  function VerticalHandle ()
  {
    this.defHandlePoint("handleV", RenderableRect, 0, 0, 2, 16)
    this.handle.dragger.lockX  = true
    this.handleV.dragger.lockX = true
  }

)

Static
(

  function make (model, pt)
  {
    var h = Handle.make(model, pt)
    h.decorate(VerticalHandle)
    return h
  }

)

Module("shape.HorizontalHandle")

Import("shape.Handle")
Import("shape.RenderableRect")

Class
(

  function HorizontalHandle ()
  {
    this.defHandlePoint("handleH", RenderableRect, 0, 0, 16, 2)
    this.handle.dragger.lockY  = true
    this.handleH.dragger.lockY = true
  }

)

Static
(

  function make (model, pt)
  {
    var h = Handle.make(model, pt)
    h.decorate(HorizontalHandle)
    return h
  }

)

