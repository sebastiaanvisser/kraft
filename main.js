var canvas = $("#canvas")[0]

var r = new Render.Rect(100, 50, 200, 300)
new Draggable(canvas, r.elem, r.elem, false, false, function () {})
canvas.appendChild(r.elem)
r.elem.style.background = "#a44"
r.render()

var l = new Render.Line(100, 50, 200, 300, 40)
new Draggable(canvas, l.elem, l.elem, false, false, function () {})
canvas.appendChild(l.elem)
l.elem.style.background = "#888"
l.render()

