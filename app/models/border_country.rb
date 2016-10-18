class BorderCountry < ActiveRecord::Base
  belongs_to :country
  belongs_to :border_country, class_name: 'Country'

  validates :border_country, presence: true
end
