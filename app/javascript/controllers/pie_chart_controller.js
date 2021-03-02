import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['element']

  connect() {
    import('easy-pie-chart').then(easyPieChart => {
      this.easyPieChart = easyPieChart.default
      this.setup()
    })
  }

  setup() {
    new this.easyPieChart(this.elementTarget, {
      animate: 2000,
      scaleColor: false,
      lineWidth: 6,
      lineCap: 'square',
      size: 90,
      trackColor: '#e5e5e5',
      barColor: this.data.get('color')
    });
  }
}
