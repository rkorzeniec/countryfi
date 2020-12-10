import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['spinner', 'content']

  hideSpinner() {
    this.spinnerTarget.classList.add('d-none')
    this.contentTarget.classList.remove('d-none')
  }
}
