# frozen_string_literal: true

json.array! @notifications do |notification|
  notification_type = notification.notifiable_type.underscore

  json.id notification.id
  json.template render(
    partial: "notifications/#{notification_type}",
    locals: { notification: notification },
    formats: [:html]
  )
end
