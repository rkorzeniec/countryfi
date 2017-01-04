class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :checkins, dependent: :destroy
  has_many :countries, -> { where('checkin_date <= ?', Time.zone.now) },
           through: :checkins
end
