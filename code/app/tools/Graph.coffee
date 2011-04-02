Module "tools.Grapher"

Static

  init: ->
    ua = navigator.userAgent
    iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i)
    typeOfCanvas = typeof HTMLCanvasElement
    nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function')
    textSupport = nativeCanvasSupport && (typeof document.createElement('canvas').getContext('2d').fillText == 'function')
    labelType = if !nativeCanvasSupport || (textSupport && !iStuff) then 'Native' else 'HTML'
    nativeTextSupport = labelType == 'Native'
    useGradients = nativeCanvasSupport
    animate = !(iStuff || !nativeCanvasSupport)


  graph: (v) ->

    gr = new $jit.RGraph
      injectInto: 'infovis'
      background:
        CanvasStyles:
          strokeStyle: '#aaa'
      Navigation:
         enable: true
         panning: 'avoid nodes'
         zooming: 10
      Node:
        overridable: true
        dim: 5
      Edge:
        overridable: true
        color: '#23A4FF'
        #type: "arrow"
        dim: 10
        lineWidth: 1.5
      Events:
        enable: true
        type: 'Native'
        # onMouseEnter: -> gr.canvas.getElement().style.cursor = 'move'
        # onMouseLeave: -> gr.canvas.getElement().style.cursor = ''
        # onDragMove: (node, eventInfo, e) ->
        #   pos = eventInfo.getPos()
        #   node.pos.setc pos.x, pos.y
        #   gr.plot()
      interpolation: 'polar'
      iterations: 200
      transition: $jit.Trans.Elastic.easeOut
      duration: 1000
      fps: 30
      levelDistance: 130
      onCreateLabel: (elem, node) ->
        elem.innerHTML += "<span class='graph-label'>#{node.name}</span>" +
                          "<span class='graph-del'>x</span>"
        $(".graph-label", elem).click -> console.log "x"; gr.onClick node.id
        $(".graph-del", elem).click ->
          node.setData 'alpha', 0, 'end'
          node.eachAdjacency (adj) -> adj.setData 'alpha', 0, 'end'
          gr.fx.animate
            modes: ['node-property:alpha', 'edge-property:alpha']
            duration: 500

      onPlaceLabel: (elem, node) ->
        st = elem.style
        st.left = ((parseInt st.left) - elem.offsetWidth / 2) + 'px'
        st.top = ((parseInt st.top) + 10) + 'px'

    gr.loadJSON (json v), 1
    gr.refresh()
    # gr.computeIncremental
    #   iter: 40
    #   property: 'end'
    #   onComplete: ->
    #     gr.animate
    #       modes: ['linear']
    #       transition: $jit.Trans.Elastic.easeOut
    #       duration: 2500

  json: (v) ->

    done = {}

    inner = (p, w) ->

      # Cycle detection.
      return [] if done[w.id]
      done[w.id] = true

      edges =
        for i, l of w.triggers
          edge =
            nodeFrom: "#{w.id}"
            nodeTo:   "#{i}"
            data: {}

      node =
        adjacencies: edges
        data:
          $color: if w.path then "#0000aa" else" #ffaa00"
          $type: "circle"
        id:   "#{w.id}"
        name: (if w.path then w.path() else w.id)

      [node].concat (inner w, t for _, t of w.triggers)...

    inner null, v

