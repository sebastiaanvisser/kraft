Module "Renderer"

Import "Prelude"
Qualified "Events", As "E"

Class

  Renderer: ->
    @queue = {}

    # Require an initial render.
    @requireRender()

    # In case something happens from the web-inspector or on application load
    # that requires a rerender, we install a setInterval to make sure things
    # get rendered. When no render is needed this trick should be cheap enough.
    E.manager.setInterval (=> @requireRender()), 50

    @

  enqueue: (o) ->
    @queue[o.id] = o
    @requireRender()

  requireRender: -> E.manager.onThreadEndOnce "Renderer", => @renderQueue()

  render: (o) -> o.render()

  Private
  renderQueue: ->
    @render o for _, o of @queue
    @queue = {}

