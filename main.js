var canvas = $("#canvas")[0]

function mkPanel ()
{
  var r = new Rect(100, 50, 200, 300)
  r.renderable(canvas)
  Selection.mkSelectable(r)
  r.elem.className += " panel"
  new Draggable(canvas, r, r.elem, false, false, 10, 10)
  return r
}

r = mkPanel()
q = mkPanel()
s = mkPanel()
t = mkPanel()

// r.mkHandles()
// render(canvas, r.handles.topLeft)
// render(canvas, r.handles.topRight)
// render(canvas, r.handles.bottomLeft)
// render(canvas, r.handles.bottomRight)
// render(canvas, r.handles.midLeft)
// render(canvas, r.handles.midRight)
// render(canvas, r.handles.midTop)
// render(canvas, r.handles.midBottom)


