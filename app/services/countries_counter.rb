class CountriesCounter
  attr_reader :user

  class << self
    def world_countries_count
      Country.count
    end

    def european_countries_count
      Country.european.count
    end

    def north_american_countries_count
      Country.north_american.count
    end

    def south_american_countries_count
      Country.south_american.count
    end

    def asian_countries_count
      Country.asian.count
    end

    def oceanian_countries_count
      Country.oceanian.count
    end

    def african_countries_count
      Country.african.count
    end

    def antarctican_countries_count
      Country.antarctican.count
    end
  end

  def initialize(user)
    @user = user
  end

  def visited_world_countries_count
    user.countries.count
  end

  def visited_european_countries_count
    user.countries.european.count
  end

  def visited_north_american_countries_count
    user.countries.north_american.count
  end

  def visited_south_american_countries_count
    user.countries.south_american.count
  end

  def visited_asian_countries_count
    user.countries.asian.count
  end

  def visited_oceanian_countries_count
    user.countries.oceanian.count
  end

  def visited_african_countries_count
    user.countries.african.count
  end

  def visited_antarctican_countries_count
    user.countries.antarctican.count
  end
end
