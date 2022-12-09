import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['label']

  updateLabel(event) {
    this.labelTarget.innerHTML = event.target.checked === true
      ? this.data.get('unchecked-text')
      : this.data.get('checked-text')
  }
}
