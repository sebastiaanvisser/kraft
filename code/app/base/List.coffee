Module "base.List"

Import "base.Obj"
Import "base.Value"

Class

  List: (revive, ls) ->
    @define "list", []
    @derive "length", 0

    # Initialize.
    @push i for i in ls if ls

  add: (i, a) ->
    @list.splice i, 0, val [i, a]
    b.v = [b.v[0] + 1, b.v[1]] for b in @list.slice i + 1
    @length = @list.length
    @changed [true, i, a]

  del: (i) ->
    [a] = @list.splice i, 1
    b.v = [b.v[0] - 1, b.v[1]] for b in @list.slice i
    a.v = [-1, a.v[1]]
    @length = @list.length
    @changed [false, i]

  push: (a) -> @add @length, a

  debug: -> (@list.map (i) -> i.v[0] + ':' + i.v[1]).join ', '

Static

  init: -> Obj.register List

  make: (args...) -> (new Obj "List").decorate List, args...

