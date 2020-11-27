import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['result']

  update(event) {
    this.resultTarget.innerHTML = this.data.get('url') + event.target.value
  }
}
