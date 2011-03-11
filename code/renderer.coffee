Module "Renderer"

Import "Prelude"
Import "Events"

Class

  Renderer: ->
    this.queue     = {}
    this.timeoutId = 0
    this.requireRender()

  enqueue: (o) ->
    this.queue[o.id] = o
    this.requireRender()

  requireRender: ->
    self = this
    Events.manager.onThreadEndOnce "Renderer", () -> self.renderQueue()

  renderQueue: ->
    this.timeoutId = 0
    self = this
    foreach this.queue, (_, o) -> self.render(o)
    this.queue = {}

  render: (o) -> o.render()

