import { Controller } from 'stimulus'
import { getControllerName } from '../src/utils/controller_name'

export default class extends Controller {
  static targets = ['element']

  connect() {
    this.element[getControllerName(this.identifier)] = this
  }

  setup() {
    import('easy-pie-chart').then(easyPieChart => {
      this.easyPieChart = easyPieChart.default
      this.render()
    })
  }

  render() {
    this.easyPieChart(this.elementTarget, {
      animate: 2000,
      scaleColor: false,
      lineWidth: 6,
      lineCap: 'square',
      size: 90,
      trackColor: '#e5e5e5',
      barColor: this.data.get('color'),
      animate: { enabled: false }
    });
  }
}
