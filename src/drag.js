function Draggable (container, target, pivot, lockX, lockY, snapX, snapY)
{
  // Dragging elements.
  this.container = container
  this.target    = target
  this.pivot     = pivot

  // Locking and snappig constraints.
  this.lockX = lockX || false
  this.lockY = lockY || false
  this.snapX = snapX || 1
  this.snapY = snapY || 1

  // Set target cursor based on drag direction.
  this.pivot.style.cursor = "move"
  if (this.lockX) this.pivot.style.cursor = "ns-resize"
  if (this.lockY) this.pivot.style.cursor = "ew-resize"

  // State, private.
  this.dragging     = false
  this.dragOrigin   = {}
  this.targetOrigin = {}

  var me = this

  $(pivot).mousedown
  ( function start (e)
    {
      me.dragging = true
      me.dragOrigin   = { x : e.clientX,      y : e.clientY     }
      me.targetOrigin = { x : me.target.left, y : me.target.top }
      $(me.target.elem).addClass("dragging")
      return false
    }
  )

  $(container).mouseup
  ( function stop (e)
    {
      if (!me.dragging) return
      me.dragging = false
      $(me.target.elem).removeClass("dragging")
    }
  )

  $(container).mousemove
  ( function drag (e)
    {
      if (!me.dragging) return true

      var dx = Math.round((e.clientX - me.dragOrigin.x) / me.snapX) * me.snapX
      var dy = Math.round((e.clientY - me.dragOrigin.y) / me.snapX) * me.snapY
      var x  = me.targetOrigin.x + dx
      var y  = me.targetOrigin.y + dy

      if (!me.lockX) me.target.left = x
      if (!me.lockY) me.target.top  = y
    }
  )

}
