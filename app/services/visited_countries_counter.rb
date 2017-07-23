class VisitedCountriesCounter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def visited_world_countries_count
    uniq_visited_count(user.countries.visited)
  end

  def visited_european_countries_count
    uniq_visited_count(user.countries_european.visited)
  end

  def visited_north_american_countries_count
    uniq_visited_count(user.countries_north_american.visited)
  end

  def visited_south_american_countries_count
    uniq_visited_count(user.countries_south_american.visited)
  end

  def visited_asian_countries_count
    uniq_visited_count(user.countries_asian.visited)
  end

  def visited_oceanian_countries_count
    uniq_visited_count(user.countries_oceanian.visited)
  end

  def visited_african_countries_count
    uniq_visited_count(user.countries_african.visited)
  end

  def visited_antarctican_countries_count
    uniq_visited_count(user.countries_antarctican.visited)
  end

  private

  def uniq_visited_count(countries)
    countries.uniq.pluck(:cca2).count
  end
end
