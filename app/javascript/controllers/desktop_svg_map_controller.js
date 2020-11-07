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
    this.svgMap = svgPanZoom(this.mapTarget, { controlIconsEnabled: true })
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

  resize() {
    this.svgMap.resize()
    this.svgMap.fit()
    this.svgMap.center()
  }

  setMouseEventDefaults() {
    this.isMoving = false
    this.isDown = false
  }
}
