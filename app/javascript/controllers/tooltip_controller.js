import { Controller } from '@hotwired/stimulus'
import '@popperjs/core';

export default class extends Controller {
  static values = { content: String, id: String }

  initialize() {
    this.container = document.body
    this.tooltip = null
  }

  show(event) {
    const tooltip = this._tooltipElement()
    event.currentTarget.setAttribute('aria-describedby', tooltip.getAttribute('id'))

    createPopper(event.currentTarget, tooltip, {
      placement: 'right',
    });

    this.container.append(tooltip)
  }

  hide() {

  }

  _tooltipElement() {
    if (!this.tooltip) {
      this.tooltip = this._createTooltipElement()
    }

    return this.tooltip
  }

  _createTooltipElement() {
    const tooltipElement = document.createElement('div')
    tooltipElement.innerHTML = this.contentValue
    tooltipElement.setAttribute('id', this.idValue)
    tooltipElement.classList.add(['transition', 'duration-150', 'ease-in-out'])

    // const tipId = "tooltip-" + Math.random().toString(16).slice(2)
    // tip.setAttribute('id', tipId)

    return tooltipElement
  }
}

