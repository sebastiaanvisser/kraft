var canvas = $("#canvas")[0]

var l = new Render.Line(100, 50, 200, 300, 40)
canvas.appendChild(l.elem)
l.elem.style.background = "#888"
l.render()
