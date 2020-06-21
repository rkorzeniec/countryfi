import Rails from 'rails-ujs';

export class Notifications {
  constructor() {
    this.getUnreadNotifications();
    this.notifications = $("[data-behavior='notifications']");
    if (this.notifications.length > 0) {
      this.handleSuccess(this.notifications.data('notifications'));
    }
  }

  getUnreadNotifications() {
    return Rails.ajax({
      url: '/notifications.json',
      type: 'GET',
      success: this.handleSuccess
    });
  }

  handleSuccess(data) {
    if(data.length == 0) { return }
    // document.getElementById('navbarNotificationsDropdown').text(items.length);

    const notifications = document.getElementById('navbarNotifications');
    notifications.classList.remove('d-none');

    const items = data.map(notification => notification.template);
    const notificationsDropdown = document.getElementById('navbarNotificationsDropdown');

    return notificationsDropdown.innerHTML = items + notificationsDropdown.innerHTML;
  }
}
