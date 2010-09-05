function Renderer ()
{
  this.queue     = {}
  this.timeoutId = 0
  this.requireRender()
}

Class(Renderer,

  function enqueue (o)
  {
    this.queue[o.id] = o
    this.requireRender()
  },

  function requireRender ()
  {
    var self = this
    Events.manager.onThreadEndOnce("R", function () { self.renderQueue() })
  },

  function renderQueue ()
  {
    this.timeoutId = 0
    var self = this
    foreach(this.queue, function (_, o) { self.render(o) })
    this.queue = {}
  },

  function render (obj) { obj.render() }

)
