var Render = {}

// ----------------------------------------------------------------------------

/*

Render.Line =
function Line (left, top, right, bottom, width)
{
  this.baseInit()

  this.elem = this.setupElem()

  this.property("left",   left   || 0, Base.effect(this.render))
  this.property("top",    top    || 0, Base.effect(this.render))
  this.property("right",  right  || 0, Base.effect(this.render))
  this.property("bottom", bottom || 0, Base.effect(this.render))
  this.property("width",  width  || 5, Base.effect(this.render))

  this.createHandles()
}

Render.Line.prototype = new Base

Render.Line.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "line")
  elem.style.position = "absolute"
  return elem
}

Render.Line.prototype.createHandles =
function createHandles ()
{
  this.handleA = new Render.Ellipse(10, 10, 30, 30)
  // this.constraint("left", this.handleA, "left", function (a) { return a})
}

Render.Line.prototype.render =
function render ()
{
  var len = Math.sqrt(Math.pow(this.right - this.left, 2) + Math.pow(this.bottom - this.top, 2))
  var rot = Math.atan((this.bottom - this.top) / (this.right - this.left)) * 180 / Math.PI

  this.elem.style.left   = ((this.left + this.right - len)        / 2) + "px"
  this.elem.style.top    = ((this.top + this.bottom - this.width) / 2) + "px"
  this.elem.style.width  = len                                         + "px"
  this.elem.style.height = this.width                                  + "px"

  this.elem.style["-webkit-transform"] = "rotate(" + rot + "deg)"
}

*/

// ----------------------------------------------------------------------------

Render.Rect =
function Rect (x0, y0, x1, y1)
{
  this.baseInit()

  this.elem = this.setupElem()

  this.property("x0", x0 || 0, Base.effect(this.render))
  this.property("y0", y0 || 0, Base.effect(this.render))
  this.property("x1", x1 || 0, Base.effect(this.render))
  this.property("y1", y1 || 0, Base.effect(this.render))

  compose( this, "width", function (w, x0, x1) { return x1 - x0 }
         , this, "x0",    function (w, x0, x1) { return x0      }
         , this, "x1",    function (w, x0, x1) { return x0 + w  }
         )

  compose( this, "left",  function (l, x0, x1, w) { return x0     }
         , this, "x0",    function (l, x0, x1, w) { return l      }
         , this, "x1",    function (l, x0, x1, w) { return l + w  }
         , this, "width", function (l, x0, x1, w) { return w      }
         )

  compose( this, "right", function (r, x0, x1, w) { return x1     }
         , this, "x0",    function (r, x0, x1, w) { return r - w  }
         , this, "x1",    function (r, x0, x1, w) { return r      }
         , this, "width", function (r, x0, x1, w) { return w      }
         )

  compose( this, "height", function (h, y0, y1) { return y1 - y0 }
         , this, "y0",     function (h, y0, y1) { return y0      }
         , this, "y1",     function (h, y0, y1) { return y0 + h  }
         )

  compose( this, "top",    function (l, y0, y1, h) { return y0     }
         , this, "y0",     function (l, y0, y1, h) { return l      }
         , this, "y1",     function (l, y0, y1, h) { return l + h  }
         , this, "height", function (l, y0, y1, h) { return h      }
         )

  compose( this, "bottom", function (r, y0, y1, h) { return y1     }
         , this, "y0",     function (r, y0, y1, h) { return r - h  }
         , this, "y1",     function (r, y0, y1, h) { return r      }
         , this, "height", function (r, y0, y1, h) { return h      }
         )
}

Render.Rect.prototype = new Base

Render.Rect.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  return elem
}

Render.Rect.prototype.render =
function render ()
{
  this.elem.style.left   = (this.x0          ) + "px"
  this.elem.style.top    = (this.y0          ) + "px"
  this.elem.style.width  = (this.x1 - this.x0) + "px"
  this.elem.style.height = (this.y1 - this.y0) + "px"
}

// ----------------------------------------------------------------------------

/*

Render.Ellipse =
function Ellipse (left, top, right, bottom)
{
  this.baseInit()

  this.elem = this.setupElem()

  this.property("left",   left   || 0, Base.effect(this.render))
  this.property("top",    top    || 0, Base.effect(this.render))
  this.property("right",  right  || 0, Base.effect(this.render))
  this.property("bottom", bottom || 0, Base.effect(this.render))
}

Render.Ellipse.prototype = new Base

Render.Ellipse.prototype.setupElem =
function setupElem ()
{
  var elem = document.createElement("div")
  elem.setAttribute("class", "rect")
  elem.style.position = "absolute"
  return elem
}

Render.Ellipse.prototype.render =
function render ()
{
  var w = this.right  - this.left;
  var h = this.bottom - this.top;

  this.elem.style.left   = this.left + "px"
  this.elem.style.top    = this.top  + "px"
  this.elem.style.width  = w         + "px"
  this.elem.style.height = h         + "px"

  this.elem.style.borderTopLeftRadius     =
  this.elem.style.borderTopRightRadius    =
  this.elem.style.borderBottomLeftRadius  =
  this.elem.style.borderBottomRightRadius = w/2 + "px " + h/2 + "px "
}

*/

