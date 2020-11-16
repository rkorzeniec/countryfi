import { Controller } from 'stimulus'
import { shadeColor } from '../src/utils/shade_color'

export default class extends Controller {
  static targets = ['country']

  initialize() {
    this.init()
    this.fillMap()
  }

  init() {
    const maxStepValue = 40

    this.countryCodes = this.getCountryCodes()
    this.countryCounts = [...this.countryCodes.values()]
    this.countryCountsMax = Math.max(...this.countryCounts)
    this.fillStep = maxStepValue / (this.countryCountsMax - Math.min(...this.countryCounts))
  }

  fillMap() {
    this.countryTargets.forEach((c) => this.fillCountry(c))
  }

  fillCountry(country) {
    if(this.countryCodes.has(country.id)) {
      const scale = this.calcFillScale(this.countryCodes.get(country.id))
      country.children[0].style.fill = shadeColor(this.data.get('color'), scale)
    }
  }

  getCountryCodes() {
    return new Map(eval(this.data.get('countryCodes')).map(i => [i[0], i[1]]));
  }

  calcFillScale(count) {
    return Math.abs(count - this.countryCountsMax) * this.fillStep
  }
}
