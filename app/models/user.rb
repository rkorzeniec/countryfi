class User < ActiveRecord::Base
  has_many :checkins, dependent: :destroy
  has_many :countries, through: :checkins

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
