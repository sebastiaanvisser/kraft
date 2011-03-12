Module "Events"

Import "Prelude"

Class

  Events: ->
    @preHooks      = {}
    @postHooks     = {}
    @preHooksOnce  = {}
    @postHooksOnce = {}
    return @

  bind: (elem, name, fn) ->
    $(elem).bind name, =>

      h() for _, h of @preHooks
      h() for _, h of @preHooksOnce
      @preHooksOnce = {}

      result = fn.apply(this, arguments)

      h() for _, h of @postHooks
      h() for _, h of @postHooksOnce
      @postHooksOnce = {}

      result

  onThreadStart:     (id, fn) -> @preHooks[id]      = fn
  onThreadEnd:       (id, fn) -> @postHooks[id]     = fn
  onThreadStartOnce: (id, fn) -> @preHooksOnce[id]  = fn
  onThreadEndOnce:   (id, fn) -> @postHooksOnce[id] = fn

Static

  init: -> Events.manager = new Events

