class Checkin < ActiveRecord::Base
  belongs_to :user, :country

  validates :user, presence: true
  validates :country, presence: true
end
