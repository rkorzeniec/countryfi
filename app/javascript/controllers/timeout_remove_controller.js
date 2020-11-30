import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['element']

  initialize() {
    setTimeout(() => this.elementTarget.remove(), this.data.get('value'));
  }
}
