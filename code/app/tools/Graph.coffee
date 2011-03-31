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

    fd = new $jit.ForceDirected
      injectInto: 'infovis'
      Navigation:
         enable: true
         panning: 'avoid nodes'
         zooming: 10
      Node:
        overridable: true
        dim: 7
      Edge:
        overridable: true
        color: '#23A4FF'
        lineWidth: 0.4
      Events:
        enable: true,
        type: 'Native',
        onMouseEnter: ->
          fd.canvas.getElement().style.cursor = 'move'
        onMouseLeave: ->
          fd.canvas.getElement().style.cursor = ''
        onDragMove: (node, eventInfo, e) ->
          pos = eventInfo.getPos()
          node.pos.setc pos.x, pos.y
          fd.plot()
      iterations: 200
      levelDistance: 130
      onCreateLabel: (elem, node) ->
        elem.innerHTML += "<span class='graph-label'>#{node.name}</span>"
      onPlaceLabel: (domElement, node) ->
        style = domElement.style
        left = parseInt style.left
        top = parseInt style.top
        w = domElement.offsetWidth
        style.left = (left - w / 2) + 'px'
        style.top = (top + 10) + 'px'
        style.display = ''

    fd.loadJSON json()

    fd.computeIncremental
      iter: 40
      property: 'end'
      onComplete: ->
        fd.animate
          modes: ['linear']
          transition: $jit.Trans.Elastic.easeOut
          duration: 2500

  json: ->
    for i in [0..19]
      node =
        adjacencies:
          for j in [0..2]
            edge =
              nodeFrom: "graphnode" + i
              nodeTo:   "graphnode" + (i + j % 18)
              data:
                $dom: 3
                $type: "arrow"
                $lineWidth: 1
        data:
          $color: "#83548B"
          $type: "circle"
        id:   "graphnode" + i
        name: "graphnode" + i

