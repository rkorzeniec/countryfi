import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['element']

  initialize() {
    console.log('FLASM')
    setTimeout(() => {
      this.elementTarget.classList.toggle('show')
      setTimeout(() => this.elementTarget.remove(), 250)
    }, this.data.get('value'));
  }

  close() {
    console.log('FLASM CLOSE')
    this.elementTarget.remove()
  }
}
