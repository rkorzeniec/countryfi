# frozen_string_literal: true

class NullUser
  def unread_notifications
    Notification.none
  end
end
