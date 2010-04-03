var canvas = $("#canvas")[0]


function drag (dx, dy)
{
  console.log(this.target, dx, dy)
}

var r = new Render.Rect(100, 50, 200, 300)
new Draggable(canvas, r, r.elem, false, false, 10, 10, drag)
canvas.appendChild(r.elem)
r.elem.style.background = "#a44"
r.render()

var c = new Render.Ellipse(100, 50, 200, 300)
new Draggable(canvas, c, c.elem, false, false, 10, 10, drag)
canvas.appendChild(c.elem)
c.elem.style.background = "#4a4"
c.render()

var l = new Render.Line(100, 50, 200, 300, 10)
new Draggable(canvas, l, l.elem, false, false, 50, 50, drag)
canvas.appendChild(l.elem)
l.elem.style.background = "#888"
l.render()

