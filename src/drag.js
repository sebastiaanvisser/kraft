function Draggable (container, target, pivot, lockX, lockY, callback)
{
  this.container = container
  this.target    = target
  this.pivot     = pivot

  this.lockX = false
  this.lockY = false

  this.snapX  = 1
  this.snapY  = 1
  // this.snapDX = 6
  // this.snapDY = 6

  this.pivot.style.cursor = "move"
  // this.target.__shape.cursor = "ew-resize"
  // this.target.__shape.cursor = "ns-resize"

  // State, private.
  this.dragging      = false
  this.dragOrigin    = {}
  this.targetOrigin  = {}

  var me = this

  $(pivot).mousedown
  ( function start (e)
    {
      me.dragging = true
      me.dragOrigin   = { x : e.clientX,            y : e.clientY           }
      me.targetOrigin = { x : me.target.offsetLeft, y : me.target.offsetTop }
      return false
    }
  )

  $(container).mouseup
  ( function stop (e)
    {
      if (!me.dragging) return
      me.dragging = false
    }
  )

  $(container).mousemove
  ( function drag (e)
    {
      if (!me.dragging) return true
      var dx = e.clientX - me.dragOrigin.x
      var dy = e.clientY - me.dragOrigin.y
      var px = me.targetOrigin.x + dx,
      var py = me.targetOrigin.y + dy
      if (!me.lockX) me.target.style.left = (Math.round(px / me.snapX) * me.snapX) + "px"
      if (!me.lockY) me.target.style.top  = (Math.round(py / me.snapY) * me.snapY) + "px"
    }
  )

}
