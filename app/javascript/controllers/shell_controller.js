import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['spinner', 'content', 'element']

  connect() {
    setTimeout(() => this.hideSpinner(), 0)
  }

  hideSpinner() {
    this.spinnerTarget.remove()
    this.contentTarget.classList.remove('d-none')
    this.render()
  }

  render() {
    this.renderSvgMapController()
    this.renderBarChartController()
    this.renderLineChartController()
  }

  renderSvgMapController() {
    this.elementTargets
      .find(e => e.dataset.controller.split(' ').includes('svg-map'))
      .svgMap
      .render()
  }

  renderBarChartController() {
    this.elementTargets
      .filter(e => e.dataset.controller === 'bar-chart')
      .forEach(e => e.barChart.render())
  }

  renderLineChartController() {
    this.elementTargets
      .find(e => e.dataset.controller === 'line-chart')
      .lineChart
      .render()
  }
}
