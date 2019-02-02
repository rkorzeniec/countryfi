class CountryLanguage < ActiveRecord::Base
  belongs_to :country

  validates :name, presence: true

  def name_and_code
    "#{name} (#{code})"
  end
end
