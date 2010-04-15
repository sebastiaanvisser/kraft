function render (container, shape, color)
{
  container.appendChild(shape.elem)
  shape.render()
  new Draggable(container, shape, shape.elem, false, false, 0, 0)
}

var canvas = $("#canvas")[0]


var r = new Render.Rect(100, 50, 200, 300)
r.elem.className += " panel"
render(canvas, r)

r.mkHandles()
render(canvas, r.handles.topLeft)
render(canvas, r.handles.topRight)
render(canvas, r.handles.bottomLeft)
render(canvas, r.handles.bottomRight)
render(canvas, r.handles.midLeft)
render(canvas, r.handles.midRight)
render(canvas, r.handles.midTop)
render(canvas, r.handles.midBottom)


