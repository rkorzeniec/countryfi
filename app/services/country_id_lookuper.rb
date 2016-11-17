class CountryIDLookuper
  def self.lookup(code)
    country = Country.find_by(cca2: code)
    return country.id unless country.nil?
  end
end
