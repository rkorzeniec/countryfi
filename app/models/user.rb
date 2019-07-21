class User < ApplicationRecord
  store :preferences, accessors: :color, coder: JSON

  has_many :checkins, dependent: :destroy
  has_many :countries, through: :checkins
  has_many :visited_checkins,
           -> { visited },
           class_name: 'Checkin',
           inverse_of: :user
  has_many :visited_countries, source: :country, through: :visited_checkins

  delegate :european, :north_american, :south_american, :asian, :oceanian,
           :african, :antarctican, to: :countries, prefix: true

  devise :database_authenticatable, :async, :registerable, :rememberable,
         :recoverable, :trackable, :validatable

  def remember_me
    true
  end
end
