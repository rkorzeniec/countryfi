class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  validates :user, presence: true
  validates :country, presence: true
end
