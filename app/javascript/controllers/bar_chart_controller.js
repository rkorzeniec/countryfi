import { Controller } from 'stimulus'
import Chartist from 'chartist'
import ctPointLabels from 'chartist-plugin-pointlabels'

export default class extends Controller {
  static targets = ['element']

  init () {
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
        Chartist.plugins.ctPointLabels({ textAnchor: 'end', align: 'right' })
      ]
    }

    /* eslint-disable no-new */
    new Chartist.Bar("#" + this.elementTarget.id, data, options)
  }
}
