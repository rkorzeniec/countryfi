import { Controller } from '@hotwired/stimulus'
import { getCSRFToken } from '../src/utils/csrf_token'

export default class extends Controller {
  static targets = ['input', 'feedback', 'submit']

  check() {
    this.checkAvailability()
  }

  checkAvailability() {
    if (this.matchingValue()) {
      this.markTargetAsAvailable()
      return
    }

    const url = this.getUrl()
    const options = {
      method: 'GET',
      credentials: 'same-origin',
      headers: { 'X-CSRF-Token': getCSRFToken() }
    }

    fetch(url, options)
      .then(response => response.json())
      .then(data => {
        if (data.availability) {
          this.markTargetAsAvailable()
        } else {
          this.markTargetAsUnavailable()
        }
      })
  }

  getUrl() {
    return this.data.get('url') + '?' +
      this.data.get('param') + '=' + encodeURIComponent(this.inputTarget.value)
  }

  markTargetAsAvailable() {
    this.inputTarget.classList.remove('is-invalid')
    this.feedbackTarget.classList.remove('invalid-feedback')

    this.inputTarget.classList.add('is-valid')
    this.feedbackTarget.classList.add('valid-feedback')
    this.feedbackTarget.innerHTML = 'Profile name is available. Don\'t forget to save.'

    this.submitTarget.disabled = false
  }

  markTargetAsUnavailable() {
    this.inputTarget.classList.remove('is-valid')
    this.feedbackTarget.classList.remove('valid-feedback')

    this.inputTarget.classList.add('is-invalid')
    this.feedbackTarget.classList.add('invalid-feedback')
    this.feedbackTarget.innerHTML = 'Profile name is unavailable. Try a different one.'

    this.submitTarget.disabled = true
  }

  matchingValue() {
    return this.inputTarget.value === this.data.get('current-value')
  }
}
