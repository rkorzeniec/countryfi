class User < ActiveRecord::Base
  has_many :checkins, dependent: :destroy
  has_many :countries, through: :checkin

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
