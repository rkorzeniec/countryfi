import { Controller } from 'stimulus'
import ctPointLabels from 'chartist-plugin-pointlabels'
import { getControllerName } from '../src/utils/controller_name'

export default class extends Controller {
  static targets = ['element']

  connect() {
    import('chartist').then(chartist => this.chartist = chartist.default)
    this.element[getControllerName(this.identifier)] = this
  }

  render() {
    const data = {
      labels: eval(this.data.get('labels')),
      series: [eval(this.data.get('values'))]
    }

    const options = {
      height: this.data.get('height'),
      seriesBarDistance: 10,
      reverseData: true,
      horizontalBars: true,
      axisY: {
        offset: 70
      },
      plugins: [
        this.chartist.plugins.ctPointLabels({ textAnchor: 'end', align: 'right' })
      ]
    }

    /* eslint-disable no-new */
    new this.chartist.Bar("#" + this.elementTarget.id, data, options)
  }
}
