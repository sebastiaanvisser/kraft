function Events ()
{
  this.preHooks      = {}
  this.postHooks     = {}
  this.preHooksOnce  = {}
  this.postHooksOnce = {}
}

Events.manager = new Events

Class(Events,

  function bind (elem, name, fn)
  {
    var self = this
    $(elem).bind(name,
      function (e)
      {
        foreach(self.preHooks,     function (_, h) { h() })
        foreach(self.preHooksOnce, function (_, h) { h() })
        self.preHooksOnce = {}

        var x = fn.apply(this, arguments) 

        foreach(self.postHooks,     function (_, h) { h() })
        foreach(self.postHooksOnce, function (_, h) { h() })
        self.postHooksOnce = {}

        return x
      })
  },

  function onThreadStart     (id, fn) { this.preHooks[id]      = fn },
  function onThreadEnd       (id, fn) { this.postHooks[id]     = fn },
  function onThreadStartOnce (id, fn) { this.preHooksOnce[id]  = fn },
  function onThreadEndOnce   (id, fn) { this.postHooksOnce[id] = fn }

)

