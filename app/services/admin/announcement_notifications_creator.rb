# frozen_string_literal: true

module Admin
  class AnnouncementNotificationsCreator
    def initialize(announcement)
      @announcement = announcement
    end

    def call
      inserts = prepare_inserts
      Notification.insert_all(inserts)
    end

    private

    attr_reader :announcement

    def prepare_inserts
      user_ids.map do |user_id|
        {
          recipient_id: user_id,
          notifiable_id: announcement.id,
          notifiable_type: announcement.class
        }
      end
    end

    def user_ids
      User.ids
    end
  end
end
