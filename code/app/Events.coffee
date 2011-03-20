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
  bind: (elem, ev, fn) ->
    callback = => @runWithHooks fn, arguments
    if isNotSupportedByJQuery ev
      elem.addEventListener ev, callback
    else
      $(elem).bind ev, callback

  setTimeout:  (fn, dly) -> window.setTimeout  (=> @runWithHooks fn, arguments), dly
  setInterval: (fn, dly) -> window.setInterval (=> @runWithHooks fn, arguments), dly

  documentReady: (fn) -> ($ document).ready => @runWithHooks fn, arguments

  onThreadStart:     (id, fn) -> @preHooks[id]      = fn
  onThreadEnd:       (id, fn) -> @postHooks[id]     = fn
  onThreadStartOnce: (id, fn) -> @preHooksOnce[id]  = fn
  onThreadEndOnce:   (id, fn) -> @postHooksOnce[id] = fn

Static

  init: -> Events.manager = new Events

  isNotSupportedByJQuery: (ev) ->
    evs =
      DOMNodeInserted:          true
      DOMNodeRemoved:           true
      DOMCharacterDataModified: true
      DOMAttrModified:          true
    evs[ev] || false

