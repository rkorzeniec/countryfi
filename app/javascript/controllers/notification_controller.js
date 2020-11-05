import { Controller } from 'stimulus'
import { getCSRFToken } from '../src/utils/csrf_token'

export default class extends Controller {
  static targets = ['element']

  markAsRead() {
    const url = '/notifications/' + this.elementTarget.id + '/mark_as_read.json'
    const options = {
      method: 'POST',
      credentials: 'same-origin',
      headers: { 'X-CSRF-Token': getCSRFToken() }
    }

    fetch(url, options)
      .then(response => response.json())
      .then(data => {
        if (data.success === 'undefined') { return }
        this.elementTarget.remove()
      })
  }
}
