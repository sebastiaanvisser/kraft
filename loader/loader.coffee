top = this

top.js = js =
  current:    undefined
  byQname:    {}
  errors:     []
  collectors: ["Qualified", "Import", "Class", "Static", "Inline", "Get", "Set"]

top.Module = (q, rest...) ->
  js.byQname[q]     = js.current = qname: q
  js.current.name   = (js.current.qname.match /[^.]*$/)[0]
  js.current.params = rest
  js.collectors.map (c) -> js.current[c] = []

js.collectors.map (c) ->
  top[c] = (args...) ->
    js.current[c].push args.map (a) -> a[c] = true; a

js.compile = (m) ->
  concat       = (a) -> [].concat.apply([], a)
  mkModuleName = (q) -> "__" + if q.match /^[^.]*$/ then q else q.replace /\./g, "_"
  inliner      = (f) -> k = f.toString(); if f.Inline then (k.match /\s*function\s+.*\s*\(\s*\;\s*{\s*(.*)\s*};?\s*$/)[1] else "\n  " + k

  for qname, mod of js.byQname

    nameFromQName = (q) -> (q.match /[^.]*$/)[0]
    name = nameFromQName qname

    assertModuleExists = (qname) ->
      if js.byQname[qname]
      then false
      else print "console.log('Module #{mod.qname} imports unknown mod #{qname}')"

    qualifiedImport = (dep) ->
      assertModuleExists dep[0]
      local  = nameFromQName (dep[1] || dep[0])
      global = "top." + mkModuleName dep[0]
      cached = global + "__cached"
      "  var #{local} = #{cached} = #{cached} || #{global}()"

    staticImport = (imp) ->
      assertModuleExists imp[0]
      c = js.byQname[imp[0]]
      ((concat c.Static).map (s) -> "  var #{s.name} = #{c.name}.#{s.name}").join "\n"

    mkFunction     = (f, n) -> "  #{name}.prototype.#{n || f.name} = \n  #{f}"
    mkAccessor     = (f, n) -> "  #{name}.prototype.__define#{f.Get ? "Getter" : "Setter"}__(\"#{n || f.name}\", \n    #{f}\n  )"
    mkMethod       = (f, n) -> if (f.Get || f.Set) then mkAccessor f, n else mkFunction f, n
    mkStaticMethod = (f) -> "  var #{f.name} = #{name}.#{f.name} = #{inliner f}"
    parameters     = (mod.params.map (p) -> "  var #{p} = #{mkModuleName p}()").join "\n"
    qualifieds     = ((mod.Import.concat mod.Qualified).map qualifiedImport).join "\n"
    imports        = (mod.Import.map staticImport).join "\n"
    collected      = concat concat(mod.Class).map (m) -> if m.constructor == Function then [[m, null]] else [f, n] for n, f of m
    methods        = (collected.map (a) -> mkMethod a...).join "\n\n"
    staticMethods  = concat(mod.Static).map(mkStaticMethod).join("\n\n")
    constructor    = "  var #{name} = " + if collected[0] then "\n  " + collected[0][0] else "{}"
    initializer    = "  if (#{name}.init) #{name}.init.apply(this, arguments)"
    moduleHeader   = mkModuleName mod.qname + " = function (" + mod.params.map(mkModuleName).join(", ") + ")\n{"
    moduleFooter   = "  return #{name}\n\n}\n"

    print [moduleHeader, parameters, qualifieds, imports, constructor, methods, staticMethods, initializer, moduleFooter, ""].join "\n\n"

