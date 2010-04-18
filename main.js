var canvas = $("#canvas")[0]

function mkPanel ()
{
  var r = new Shape(100, 50, 200, 300)
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

