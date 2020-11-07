import { Controller } from 'stimulus'
import svgPanZoom from 'svg-pan-zoom'

export default class extends Controller {
  static targets = ['map']

  initialize() {
    this.initMap()

    this.mapElements = this.mapTarget.querySelectorAll('[data-toggle="tooltip"]')
    this.setMouseEventDefaults()
    this.initMouseEvents()
  }

  initMap() {
    this.svgMap = svgPanZoom(
      this.mapTarget,
      {
        zoomEnabled: true,
        controlIconsEnabled: true,
        fit: 1,
        center: 1,
        customEventsHandler: this.mobileEventsHandler()
      }
    )
  }

  initMouseEvents() {
    this.initMouseDown()
    this.initMouseUp()
  }

  initMouseDown() {
    this.mapElements.forEach((e) => {
      e.addEventListener('mousedown', () => this.isDown = true)
      e.addEventListener('mousemove', () => {
        if (this.isDown === false) { return }

        this.isMoving = true
      })
    })
  }

  initMouseUp() {
    this.mapElements.forEach((e) => {
      e.addEventListener('click', (event) => {
        if (this.isDown && this.isMoving) {
          event.preventDefault()
          event.stopImmediatePropagation()
        }

        this.setMouseEventDefaults()
      })
    })
  }

  get map() {
    return this.svgMap
  }

  resize() {
    this.svgMap.resize()
    this.svgMap.fit()
    this.svgMap.center()
  }

  setMouseEventDefaults() {
    this.isMoving = false
    this.isDown = false
  }

  mobileEventsHandler() {
    return {
      haltEventListeners: ['touchstart', 'touchend', 'touchmove', 'touchleave', 'touchcancel'],
      init: function(options) {
        var instance = options.instance,
          initialScale = 1,
          pannedX = 0,
          pannedY = 0

        // Init Hammer
        // Listen only for pointer and touch events
        this.hammer = Hammer(options.svgElement, {
          inputClass: Hammer.SUPPORT_POINTER_EVENTS ? Hammer.PointerEventInput : Hammer.TouchInput
        })

        // Enable pinch
        this.hammer.get('pinch').set({enable: true})

        // Handle double tap
        this.hammer.on('doubletap', function(ev){
          instance.zoomIn()
        })

        // Handle pan
        this.hammer.on('panstart panmove', function(ev){
          // On pan start reset panned variables
          if (ev.type === 'panstart') {
            pannedX = 0
            pannedY = 0
          }

          // Pan only the difference
          instance.panBy({x: ev.deltaX - pannedX, y: ev.deltaY - pannedY})
          pannedX = ev.deltaX
          pannedY = ev.deltaY
        })

        // Handle pinch
        this.hammer.on('pinchstart pinchmove', function(ev){
          // On pinch start remember initial zoom
          if (ev.type === 'pinchstart') {
            initialScale = instance.getZoom()
            instance.zoomAtPoint(initialScale * ev.scale, {x: ev.center.x, y: ev.center.y})
          }

          instance.zoomAtPoint(initialScale * ev.scale, {x: ev.center.x, y: ev.center.y})
        })

        // Prevent moving the page on some devices when panning over SVG
        options.svgElement.addEventListener('touchmove', function(e){ e.preventDefault(); });
      },

      destroy: function(){
        this.hammer.destroy()
      }
    }
  }
}
