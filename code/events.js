function Events ()
{
  this.preHooks   = {}
  this.postHooks  = {}
  this.preHooks1  = {}
  this.postHooks1 = {}
}

Events.manager = new Events

Class(Events,

  function bind (elem, name, fn)
  {
    var self = this
    $(elem).bind(name,
      function (e)
      {
        foreach(self.preHooks,  function (_, h) { h() })
        foreach(self.preHooks1, function (_, h) { h() })
        self.preHooks1 = {}

        var x = fn.apply(this, arguments) 

        foreach(self.postHooks,  function (_, h) { h() })
        foreach(self.postHooks1, function (_, h) { h() })
        self.postHooks1 = {}

        return x
      })
  },

  function onThreadStart     (id, fn) { this.preHooks[id]   = fn },
  function onThreadEnd       (id, fn) { this.postHooks[id]  = fn },
  function onThreadStartOnce (id, fn) { this.preHooks1[id]  = fn },
  function onThreadEndOnce   (id, fn) { this.postHooks1[id] = fn }

)
