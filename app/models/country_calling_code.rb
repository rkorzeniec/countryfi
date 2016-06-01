class CountryCallingCode < ActiveRecord::Base
  belongs_to :country

  validates :calling_code, presence: true
end
