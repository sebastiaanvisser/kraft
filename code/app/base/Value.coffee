Module "base.Value"

Import "Prelude"

Class

  Value: (v, parent, name, soft, t) ->

    @parent    = parent
    @name      = name
    @soft      = soft # Soft properties will not be serialized.
    @type      = t || v.constructor.name
    @value     = if @type == "Number" then 1 * v else v
    @triggers  = {}
    @busy      = false
    @normalize = null

    get = => @value

    set = (v) =>
      w = if @normalize then @normalize v else v
      w = if @type == "Number" then 1 * w else w
      return if @value == w or @busy
      @busy = true
      @value = w
      t[1].app t[0] for _, t of @triggers
      @parent.changed [@] if @parent and not soft
      @busy = false

    if @parent
      @parent.__defineGetter__ @name, get
      @parent.__defineSetter__ @name, set

    @__defineGetter__ "v", get
    @__defineSetter__ "v", set
    @

  destructor: ->
    t[1].destructor() for _, t of @triggers
    @value.destructor() if @value.destructor

  identifier: ->
    if @parent then @parent.identifier() + '.' + @name else @name

Static

  val: (v) -> if v and v.triggers then v else new Value v

