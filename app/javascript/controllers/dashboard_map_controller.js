import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['country']

  initialize() {
    this.initMap()
  }

  initMap() {
    this.countryTargets.forEach((c) => this.fillCountry(c))
  }

  fillCountry(country) {
    if(this.data.get('countryCodes').includes(country.id)) {
      country.children[0].style.fill = this.data.get('color')
    }
  }
}
