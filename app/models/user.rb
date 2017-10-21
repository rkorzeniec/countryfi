class User < ActiveRecord::Base
  has_many :checkins, dependent: :destroy
  has_many :countries, through: :checkins
  has_many :visited_checkins, -> { visited }, class_name: 'Checkin'
  has_many :visited_countries, source: :country, through: :visited_checkins

  delegate :european, :north_american, :south_american, :asian, :oceanian,
           :african, :antarctican, to: :countries, prefix: true

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
