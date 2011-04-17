Module "base.Transaction"

Class

  Transaction: ->
    @tid       = 0
    @busy      = 0
    @actions   = []
    @commits   = []
    @actionLog = {}
    @commitLog = {}
    @

  start: (id, fn) ->
    return if @actionLog[id]
    @actions.push [id, fn]
    @actionLog[id] = id

  end: (id, fn) ->
    return if @commitLog[id]
    @commits.push [id, fn]
    @commitLog[id] = id

  commit: (id) ->
    return if @busy
    @busy = true
    @processQueue @actions, @actionLog
    @processQueue @commits, @commitLog
    @busy = false

  processQueue: (q, r) ->
    while q.length
      [id, action] = q.shift()
      delete r[id]
      action()

