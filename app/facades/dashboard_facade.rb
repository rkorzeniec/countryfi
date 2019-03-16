class DashboardFacade
  attr_reader :countries

  def initialize(user)
    @user = user
    @countries = Country.all.load
  end

  def country_code_array
    visited_countries.pluck(:cca2)
  end

  def european_countries
    @european_countries ||= countries.european
  end

  def north_american_countries
    @north_american_countries ||= countries.north_american
  end

  def south_american_countries
    @south_american_countries ||= countries.south_american
  end

  def asian_countries
    @asian_countries ||= countries.asian
  end

  def african_countries
    @african_countries ||= countries.african
  end

  def oceanian_countries
    @oceanian_countries ||= countries.oceanian
  end

  def antarctican_countries
    @antarctican_countries ||= countries.antarctican
  end

  def visited_countries_counter
    @visited_countries_counter ||= ::Dashboard::VisitedCountriesCounter.new(user)
  end

  private

  attr_reader :user

  def visited_countries
    @visited_countries ||= user.visited_countries.load
  end
end
