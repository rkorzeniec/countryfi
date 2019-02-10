class DashboardFacade
  def initialize(user)
    @user = user
    @countries = Country.all.load
  end

  def country_id(index)
    countries && countries[index]&.id
  end

  def european_country_id(index)
    european_countries[index]&.id
  end

  def north_american_country_id(index)
    north_american_countries[index]&.id
  end

  def south_american_country_id(index)
    south_american_countries[index]&.id
  end

  def asian_country_id(index)
    asian_countries[index]&.id
  end

  def african_country_id(index)
    african_countries[index]&.id
  end

  def oceanian_country_id(index)
    oceanian_countries[index]&.id
  end

  def antarctican_country_id(index)
    antarctican_countries[index]&.id
  end

  def country_code_array
    visited_countries.pluck(:cca2)
  end

  def visited_countries_counter
    VisitedCountriesCounter.new(user)
  end

  private

  attr_reader :user, :countries

  def visited_countries
    @visited_countries ||= user.visited_countries.load
  end

  def european_countries
    @european_countries ||= countries.european
    # countries.select do |country|
    #   country.region
    # end
  end

  def north_american_countries
    @north_american_countries ||= countries.north_american
    # countries.select do |country|
    #   country.region
    # end
  end

  def south_american_countries
    @south_american_countries ||= countries.south_american
    # countries.select do |country|
    #   country.region
    # end
  end

  def asian_countries
    @asian_countries ||= countries.asian
    # countries.select do |country|
    #   country.region
    # end
  end

  def african_countries
    @african_countries ||= countries.african
    # countries.select do |country|
    #   country.region
    # end
  end

  def oceanian_countries
    @oceanian_countries ||= countries.oceanian
    # countries.select do |country|
    #   country.region
    # end
  end

  def antarctican_countries
    @antarctican_countries ||= countries.antarctican
    # countries.select do |country|
    #   country.region
    # end
  end
end
