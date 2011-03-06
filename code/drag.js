function Draggable (container, target, pivot, lockX, lockY, snapX, snapY, zoom)
{
  // Dragging elements.
  this.container = container
  this.target    = target
  this.pivot     = pivot
  this.zoom      = zoom


  // Locking and snappig constraints.
  this.lockX = lockX || false
  this.lockY = lockY || false
  this.snapX = snapX || 1
  this.snapY = snapY || 1

  // Add a class indicating this element is draggable.
  $(this.target.elem).addClass("draggable")

  // State, private.
  this.dragging     = false
  this.dragOrigin   = {}
  this.targetOrigin = {}

  var me = this

  Events.manager.bind(pivot, "mousedown",
    function start (e)
    {
      me.dragging = true
      me.dragOrigin   = { x : e.clientX,      y : e.clientY     }
      me.targetOrigin = { x : me.target.left, y : me.target.top }
      $(me.target.elem).addClass("dragging")
      return false
    })

  Events.manager.bind(container, "mouseup",
    function stop (e)
    {
      if (!me.dragging) return
      me.dragging = false
      $(me.target.elem).removeClass("dragging")
    })

  Events.manager.bind(container, "mousemove",
    function drag (e)
    {
      if (!me.dragging) return true

      var snX = me.snapX * me.zoom.v
      var snY = me.snapY * me.zoom.v

      var dx = (Math.round((e.clientX - me.dragOrigin.x) / snX) * snX) / me.zoom.v
      var dy = (Math.round((e.clientY - me.dragOrigin.y) / snY) * snY) / me.zoom.v
      var x  = me.targetOrigin.x + dx
      var y  = me.targetOrigin.y + dy

      if (!me.lockX) me.target.left = x
      if (!me.lockY) me.target.top  = y
    })

}
