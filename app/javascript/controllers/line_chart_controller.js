import { Controller } from 'stimulus'
import Chartist from 'chartist'

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
      }
    }

    /* eslint-disable no-new */
    new Chartist.Line("#" + this.elementTarget.id, data, options)
  }
}
