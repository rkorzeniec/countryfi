import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['rootElement', 'dropdown']

  connect() {
    this.fetchUnreadNotifications()
  }

  fetchUnreadNotifications() {
    fetch('/notifications.json')
      .then(response => response.json())
      .then(data => {
        if(data.length == 0) { return }

        this.populateNotifications(data)
        this.showNotifications()
      })
  }

  populateNotifications(data) {
    const items = data.map(notification => notification.template);
    this.dropdownTarget.innerHTML = items.join("") + this.dropdownTarget.innerHTML;
  }

  showNotifications() {
    this.rootElementTarget.classList.remove('d-none');
  }
}
