# Utilties.

concat = (a) -> [].concat a...

# Top level loader structures.

top = this
top.js = js =
  current:    undefined
  modules:    {}
  errors:     []
  importers:  "Qualified Import".split ' '
  collectors: "Class Static Private Get Set".split ' '

js.keywords = concat [js.importers, js.collectors]

# Install the module initializer nollector in the global namespace.

top.Module = (q, rest...) ->

  # Build module.
  js.modules[q] =
    js.current =
      qname:   q
      name:    q.match(/[^.]*$/)[0]
      params:  rest
      methods: {}

  # Build initial collector buckets.
  js.current[c] = [] for c in js.keywords

# Install all other keywords in the global namespace.

js.keywords.map (c) ->
  top[c] = (args...) -> js.current[c].push args
  top[c].annotation = c

# -----------------------------------------------------------------------------

js.compile = ->
  js.prepare()
  js.codegen()

js.prepare = ->

  flatten = (mod, def, bucket) ->
    as = {}; as[def] = true
    for m in concat bucket
      switch m.constructor
        when Function then as[m.annotation] = true
        when Object
          for n, f of m
            mod.methods[n] = f
            f.annotations = as
            as = {}; as[def] = true

  for _, mod of js.modules
    flatten mod, c, mod[c] for c in js.collectors

js.codegen = ->
  mkModuleName = (q) -> "__" + if q.match /^[^.]*$/ then q else q.replace /\./g, "_"

  for qname, mod of js.modules

    #print "// #{qname}"
    #print "  // s: #{n} #{k for k of f.annotations}" for n, f of mod.methods

    nameFromQName = (q) -> (q.match /[^.]*$/)[0]
    name = nameFromQName qname

    assertModuleExists = (qname) -> {}
      # throw "Module #{mod.qname} imports unknown mod #{qname}" unless js.modules[qname]

    qualifiedImport = (dep) ->
      assertModuleExists dep[0]
      local  = nameFromQName (dep[1] || dep[0])
      global = "top." + mkModuleName dep[0]
      cached = global + "__cached"
      "  var #{local} = #{cached} = #{cached} || #{global}()"

    staticImport = (imp) ->
      assertModuleExists imp[0]
      m = js.modules[imp[0]]
      eligible = (f) -> f.annotations.Static and not f.annotations.Private
      ("  var #{n || f.name} = #{m.name}.#{n || f.name}" for n, f of m.methods when eligible f).join "\n"

    mkFunction   = (f, n) -> "  #{name}.prototype.#{n || f.name} = \n  #{f}"
    mkAccessor   = (f, n) -> "  #{name}.prototype.__define#{f.Get ? "Getter" : "Setter"}__(\"#{n || f.name}\", \n    #{f}\n  )"
    mkMethod     = (f, n) -> mkFunction f, n
    mkStatic     = (f, n) -> "  var #{n || f.name} = #{name}.#{n || f.name} = #{f.toString()}"
    qualifieds   = (qualifiedImport q for q in concat [mod.Qualified, mod.Import]).join "\n"
    imports      = (staticImport    i for i in                        mod.Import ).join "\n"
    methods      = (mkMethod f, n for n, f of mod.methods when not f.annotations.Static and n != name).join "\n\n"
    statics      = (mkStatic f, n for n, f of mod.methods when     f.annotations.Static              ).join "\n\n"
    constructor  = "  var #{name} = " + if mod.methods[name] then "\n  " + mod.methods[name] else "{}"
    initializer  = "  if (#{name}.init) #{name}.init.apply(this, arguments)"
    moduleHeader = mkModuleName mod.qname + " = function ()\n{"
    moduleFooter = "  return #{name}\n}\n"

    print [ moduleHeader
            qualifieds
            imports
            constructor
            methods
            statics
            initializer
            moduleFooter
          ].join "\n\n"

