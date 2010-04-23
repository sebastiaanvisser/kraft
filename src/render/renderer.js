function Renderer ()
{
  this.queue     = {}
  this.timeoutId = 0
}

addToProto(Renderer,

  function enqueue (o)
  {
    this.queue[o.id] = o

    var self = this
    Events.manager.onThreadEndOnce("R", function () { self.renderQueue() })

    // var self = this
    // if (!this.timeoutId) this.timeoutId = setTimeout(function () { self.renderQueue() })
  },

  function renderQueue ()
  {
    this.timeoutId = 0
    var self = this
    foreach(this.queue, function (o) { self.render(o) })
    this.queue = {}
  },

  function render (obj) { obj.render() }

)
