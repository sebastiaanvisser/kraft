Module "Renderer"

Import "Prelude"
Qualified "Events", "E"

Class

  Renderer: ->
    @queue     = {}
    @timeoutId = 0
    @requireRender()

  enqueue: (o) ->
    @queue[o.id] = o
    @requireRender()

  requireRender: ->
    E.manager.onThreadEndOnce "Renderer", => @renderQueue()

  render: (o) -> o.render()

  Private
  renderQueue: ->
    @timeoutId = 0
    @render o for _, o of @queue
    @queue = {}

