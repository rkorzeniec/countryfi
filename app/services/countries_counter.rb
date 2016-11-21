class CountriesCounter
  attr_reader :user

  class << self
    def european_countries_count
      Country.where(region: 'Europe').count
    end

    def north_american_countries_count
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

    def south_american_countries_count
      Country.where(subregion: 'South America').count
    end

    def asian_countries_count
      Country.where(region: 'Asia').count
    end

    def oceanian_countries_count
      Country.where(region: 'Oceania').count
    end

    def african_countries_count
      Country.where(region: 'Africa').count
    end
  end

  def initialize(user)
    @user = user
  end

  def visited_european_countries_count
    user.countries.where(region: 'Europe').count
  end

  def visited_north_american_countries_count
    user.countries.where([
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

  def visited_south_american_countries_count
    user.countries.where(subregion: 'South America').count
  end

  def visited_asian_countries_count
    user.countries.where(region: 'Asia').count
  end

  def visited_oceanian_countries_count
    user.countries.where(region: 'Oceania').count
  end

  def visited_african_countries_count
    user.countries.where(region: 'Africa').count
  end
end
