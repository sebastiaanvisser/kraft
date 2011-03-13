Module "Events"

Import "Prelude"

Class

  Events: ->
    @preHooks      = {}
    @postHooks     = {}
    @preHooksOnce  = {}
    @postHooksOnce = {}
    return @

  Private
  runWithHooks: (fn, args) ->

    h() for _, h of @preHooks
    h() for _, h of @preHooksOnce
    @preHooksOnce = {}

    result = fn args...

    h() for _, h of @postHooks
    h() for _, h of @postHooksOnce
    @postHooksOnce = {}

    result

  # Use jQuery to bind a custom events handler to an element.
  bind: (elem, name, fn) -> $(elem).bind name, => @runWithHooks fn, arguments

  setTimeout:  (fn, dly) -> window.setTimeout  (=> @runWithHooks fn, arguments), dly
  setInterval: (fn, dly) -> window.setInterval (=> @runWithHooks fn, arguments), dly

  onThreadStart:     (id, fn) -> @preHooks[id]      = fn
  onThreadEnd:       (id, fn) -> @postHooks[id]     = fn
  onThreadStartOnce: (id, fn) -> @preHooksOnce[id]  = fn
  onThreadEndOnce:   (id, fn) -> @postHooksOnce[id] = fn

Static

  init: -> Events.manager = new Events

