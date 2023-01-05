import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['spinner', 'content', 'element']

  connect() {
    setTimeout(() => this.hideSpinner(), 350)
  }

  hideSpinner() {
    this.spinnerTarget.remove()
    this.contentTarget.classList.remove('invisible')
    this.render()
  }

  render() {
    this.renderSvgMapController()
    this.renderPieChartController()
    this.renderBarChartController()
    this.renderLineChartController()
  }

  renderSvgMapController() {
    this.elementTargets
      .find(e => e.dataset.controller.split(' ').includes('svg-map'))
      ?.svgMap.render()
  }

  renderPieChartController() {
    this.elementTargets
      .filter(e => e.dataset.controller === 'pie-chart')
      .forEach(e => e.pieChart.setup())
  }

  renderBarChartController() {
    this.elementTargets
      .filter(e => e.dataset.controller === 'bar-chart')
      .forEach(e => e.barChart.render())
  }

  renderLineChartController() {
    this.elementTargets
      .find(e => e.dataset.controller === 'line-chart')
      ?.lineChart.render()
  }
}
