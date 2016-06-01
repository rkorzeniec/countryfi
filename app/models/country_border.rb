class CountryBorder < ActiveRecord::Base
  belongs_to :country

  validates :border_country_id, presence: true
end
