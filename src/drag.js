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
  this.dragging      = false
  this.dragOrigin    = {}
  this.targetOrigin  = {}

  var me = this

  $(pivot).mousedown
  ( function start (e)
    {
      me.dragging = true
      me.dragOrigin   = { x : e.clientX
                        , y : e.clientY
                        }
      me.targetOrigin = { left  : me.target.left,  top    : me.target.top
                        , right : me.target.right, bottom : me.target.bottom
                        }
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

      var left   = me.targetOrigin.left   + dx
      var right  = me.targetOrigin.right  + dx
      var top    = me.targetOrigin.top    + dy
      var bottom = me.targetOrigin.bottom + dy

      if (!me.lockX) { me.target.left   = Math.round(left   / me.snapX) * me.snapX
                       me.target.right  = Math.round(right  / me.snapX) * me.snapX }
      if (!me.lockY) { me.target.top    = Math.round(top    / me.snapY) * me.snapY
                       me.target.bottom = Math.round(bottom / me.snapY) * me.snapY }
    }
  )

}
