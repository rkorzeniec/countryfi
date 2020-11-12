import { Controller } from 'stimulus'
import Chartist from 'chartist'

export default class extends Controller {
  static targets = ['element']

  initialize () {
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
      }
    }

    /* eslint-disable no-new */
    new Chartist.Bar("#" + this.elementTarget.id, data, options)
  }
}
