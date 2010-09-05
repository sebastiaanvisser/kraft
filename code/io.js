function IO () { }

Static(IO,

  function save (name, message, data)
  {
    $.ajax
      ({ type    : 'PUT'
       , url     : 'http://localhost:8000/' + name + "?" + message
       , data    : data
       , success : function () {}
       , error   : function () {}
       })
  },

  function load (name, cb)
  {
    $.ajax
      ({ type    : 'GET'
       , url     : 'http://localhost:8000/' + name
       , success : cb
       , error   : function () {}
       })
  }

)

