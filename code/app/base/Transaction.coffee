Module "base.Transaction"

Class

  Transaction: ->
    @tid    = 0
    @busy   = 0
    @done   = {}
    @log    = []
    @oncommit = []
    @

  begin: (id, fn) -> @log.push [id, fn]
  end:   (id, fn) -> @oncommit.push [id, fn]

  commit: (id) ->
    return if @busy
    @busy = true
    @processQueue @log
    @processQueue @oncommit
    @busy = false

  processQueue: (q) ->
    @done = {}
    while q.length
      [id, action] = q.shift()
      action() unless @done[id]
      @done[id] = true

