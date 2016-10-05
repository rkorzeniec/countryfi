class CountryIDLookuper
  def self.lookup(code)
    Country.find_by(cca2: code).id
  end
end
