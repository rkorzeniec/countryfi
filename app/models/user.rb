# frozen_string_literal: true

class User < ApplicationRecord
  store :preferences, accessors: %i[color countries_cluster], coder: JSON

  has_secure_token :jti_token

  has_many :checkins, dependent: :destroy
  has_many :past_checkins,
           -> { in_past },
           class_name: 'Checkin',
           inverse_of: :user
  has_many :visited_countries, source: :country, through: :past_checkins
  has_many :notifications,
           foreign_key: :recipient_id,
           dependent: :destroy,
           inverse_of: :recipient

  delegate :european, :north_american, :south_american, :asian, :oceanian,
           :african, :antarctican, to: :countries, prefix: true

  devise :database_authenticatable, :async, :registerable, :rememberable,
         :recoverable, :trackable, :validatable

  def remember_me
    true
  end
end
