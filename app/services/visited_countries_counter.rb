class VisitedCountriesCounter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visited_world_countries_count
    user.countries.count
  end

  def visited_european_countries_count
    user.countries_european.count
  end

  def visited_north_american_countries_count
    user.countries_north_american.count
  end

  def visited_south_american_countries_count
    user.countries_south_american.count
  end

  def visited_asian_countries_count
    user.countries_asian.count
  end

  def visited_oceanian_countries_count
    user.countries_oceanian.count
  end

  def visited_african_countries_count
    user.countries_african.count
  end

  def visited_antarctican_countries_count
    user.countries_antarctican.count
  end
end
