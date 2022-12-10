# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :recipient, class_name: 'User'

  delegate :message, to: :notifiable

  scope :unread, -> { where(read_at: nil) }
  scope :with_notifiable, -> { includes(:notifiable) }

  def mark_as_read
    update(read_at: Time.current)
  end
end
