class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :checkins, dependent: :destroy
  has_many :countries, -> { where('checkin_date <= ?', Time.zone.now) },
           through: :checkins

  delegate :european, :north_american, :south_american, :asian, :oceanian,
           :african, :antarctican, to: :countries, prefix: true
end
