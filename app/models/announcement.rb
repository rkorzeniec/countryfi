# frozen_string_literal: true

class Announcement < ApplicationRecord
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :message, presence: true, length: { maximum: 255 }
end
