class CountriesCounter
  def self.european_countries_count
    Country.where(region: 'Europe').count
  end

  def self.north_american_countries_count
    Country.where([
      "region = 'Americas' AND "\
      "subregion = :north_america OR "\
      "subregion = :central_america OR "\
      "subregion = :caribbean",
      {
        north_america: 'North America',
        central_america: 'Central America',
        caribbean: 'Caribbean'
      }
    ]).count
  end

  def self.south_american_countries_count
    Country.where(subregion: 'South America').count
  end

  def self.asian_countries_count
    Country.where(region: 'Asia').count
  end

  def self.oceanian_countries_count
    Country.where(region: 'Oceania').count
  end

  def self.african_countries_count
    Country.where(region: 'Africa').count
  end
end
