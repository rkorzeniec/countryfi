# frozen_string_literal: true

class CountryIdFinder
  def self.lookup(code)
    Country.find_by(cca2: code)&.id.presence
  end
end
