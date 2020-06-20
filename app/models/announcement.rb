# frozen_string_literal: true

class Announcement < ApplicationRecord
  has_many :notifications, dependent: :destroy

  validates :message, presence: true, length: { maximum: 255 }
end
