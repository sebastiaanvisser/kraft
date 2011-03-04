function RenderableEllipse (revive, ctx)
{
  this.canvas = ctx
  this.elem   = this.setupElem()

  this.onchange(function () { this.canvas.renderer.enqueue(this) })
  this.changed()
}

Base.register(RenderableEllipse)

Class(RenderableEllipse,

  function setupElem ()
  {
    var elem = document.createElement("div")
    $(elem).addClass("ellipse")
    elem.style.position = "absolute"
    this.canvas.elem.appendChild(elem)
    return elem
  },

  function destructor ()
  {
    this.unrender()
  },

  function render ()
  {
    var w = this.right  - this.left
    var h = this.bottom - this.top

    this.elem.style.left   = this.left + "px"
    this.elem.style.top    = this.top  + "px"
    this.elem.style.width  = w         + "px"
    this.elem.style.height = h         + "px"

    this.elem.style.borderTopLeftRadius     =
    this.elem.style.borderTopRightRadius    =
    this.elem.style.borderBottomLeftRadius  =
    this.elem.style.borderBottomRightRadius = w/2 + "px " + h/2 + "px "
  },

  function unrender ()
  {
    this.canvas.elem.removeChild(this.elem)
  }

)

