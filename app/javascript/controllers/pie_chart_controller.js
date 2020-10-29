import { Controller } from 'stimulus'
import EasyPieChart from 'easy-pie-chart';

export default class extends Controller {
  static targets = ['element']

  connect() {
    console.log('Hello from stimulus!');
    this.setup()
  }

  setup() {
    new EasyPieChart(this.elementTarget, {
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
