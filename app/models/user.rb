class User < ActiveRecord::Base
  has_many :checkins, dependent: :destroy
  has_many :countries, through: :checkins do
    def visited
      where('checkin_date <= ?', Time.zone.now)
    end
  end

  delegate :european, :north_american, :south_american, :asian, :oceanian,
           :african, :antarctican, to: :countries, prefix: true

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
