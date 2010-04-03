function render (container, shape, color)
{
  container.appendChild(shape.elem)
  shape.elem.style.background = color
  shape.render()
}

var canvas = $("#canvas")[0]


var r = new Render.Rect(100, 50, 200, 300)
new Draggable(canvas, r, r.elem, false, false, 10, 10)
render(canvas, r, "#a44")

var c = new Render.Ellipse(100, 50, 200, 300)
new Draggable(canvas, c, c.elem, false, false, 10, 10)
render(canvas, c, "#4a4")

var l = new Render.Line(100, 50, 200, 300, 10)
new Draggable(canvas, l, l.elem, false, false, 50, 50)
render(canvas, l, "#000")

// render(canvas, l.handleA, "blue")
// render(canvas, l.handleB, "blue")

