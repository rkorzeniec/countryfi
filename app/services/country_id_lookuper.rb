# frozen_string_literal: true
class CountryIDLookuper
  def self.lookup(code)
    country = Country.find_by(cca2: code)
    country.nil? ? nil : country.id
  end
end
