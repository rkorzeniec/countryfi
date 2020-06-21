import Rails from 'rails-ujs';

const showNotifications = function () {
  const notifications = document.getElementById('navbarNotifications');
  notifications.classList.remove('d-none');
}

const populateNotifications = function (data) {
  const items = data.map(notification => notification.template);
  const notificationsDropdown = document.getElementById('navbarNotificationsDropdown');
  notificationsDropdown.innerHTML = items + notificationsDropdown.innerHTML;
}

const bindNotificationLinks = function () {
  const notificationLinks = document.querySelectorAll("[data-behavior='notification-link']")
  notificationLinks.forEach(markAsReadListener)
}

const markAsReadListener = function(element) {
  element.addEventListener('click', markNotificationAsRead)
}

const markNotificationAsRead = function (event) {
  Rails.ajax({
    url: '/notifications/' + event.currentTarget.id + '/mark_as_read',
    type: 'POST',
    success: markAsReadCallback
  })
}

const markAsReadCallback = function (data) {
  if (data.success === 'undefined') { return }
  document.getElementById('notification-' + data.id).remove()
}

export class Notifications {
  constructor() {
    this.getUnreadNotifications();
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
    showNotifications();
    populateNotifications(data);
    bindNotificationLinks();
  }
}
