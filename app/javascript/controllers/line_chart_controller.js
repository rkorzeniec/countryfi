import { Controller } from 'stimulus'
import Chartist from 'chartist'
import 'chartist-plugin-pointlabels'

export default class extends Controller {
  static targets = ['element']

  initialize () {
    const data = {
      labels: eval(this.data.get('labels')),
      series: [
        { name: 'all', data: eval(this.data.get('values'))[0] },
        { name: 'unique', data: eval(this.data.get('values'))[1] }
      ]
    }

    const options = {
      height: this.data.get('height'),
      fullWidth: true,
      chartPadding: {
        right: 40
      },
      plugins: [
        Chartist.plugins.ctPointLabels()
      ]
    }

    const responsiveOptions = [
      ['screen and (max-width: 768px)', {
        fullWidth: true,
        chartPadding: { right: 5, left: 0 },
        axisX: {
          labelOffset: { x: -12 },
          labelInterpolationFnc: (value) => "'" + value.toString().slice(-2)
        }
      }]
    ]

    /* eslint-disable no-new */
    new Chartist.Line("#" + this.elementTarget.id, data, options, responsiveOptions)
  }
}
