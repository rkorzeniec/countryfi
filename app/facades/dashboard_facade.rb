# frozen_string_literal: true

class DashboardFacade
  CACHE_EXPIRY = 1.week

  attr_reader :countries

  def initialize(user)
    @user = user
    @countries = Country.all.load
  end

  def country_code_array
    cache_fetch(__method__) { visited_countries.pluck(:cca2) }
  end

  def european_countries
    cache_fetch(__method__) { countries.european }
  end

  def north_american_countries
    cache_fetch(__method__) { countries.north_american }
  end

  def south_american_countries
    cache_fetch(__method__) { countries.south_american }
  end

  def asian_countries
    cache_fetch(__method__) { countries.asian }
  end

  def african_countries
    cache_fetch(__method__) { countries.african }
  end

  def oceanian_countries
    cache_fetch(__method__) { countries.oceanian }
  end

  def antarctican_countries
    cache_fetch(__method__) { countries.antarctican }
  end

  def visited_countries_counter
    @visited_countries_counter ||=
      ::Dashboard::VisitedCountriesCounter.new(user)
  end

  def countries_yearly_chart_data
    cache_fetch(__method__) do
      [
        { name: 'all', query: VisitedCountriesQuery.new(user).count_by_year },
        { name: 'unique', query: UniqVisitedCountriesQuery.new(user).count_by_year }
      ]
    end
  end

  def top_countries_chart_data
    cache_fetch(__method__) do
      TopCountriesQuery.new(visited_countries).query
    end
  end

  def top_regions_chart_data
    cache_fetch(__method__) do
      TopRegionsQuery.new(visited_countries).query
    end
  end

  private

  attr_reader :user

  def visited_countries
    @visited_countries ||= user.visited_countries.load
  end

  def cache_fetch(method_name)
    Rails.cache.fetch(cache_key(method_name), expires_in: CACHE_EXPIRY) do
      Rails.logger.info(cache_key(method_name))
      yield
    end
  end

  def cache_key(method_name)
    [
      self.class.to_s.underscore,
      method_name,
      user.id,
      last_visited_checkin_id
    ].compact.join('/')
  end

  def last_checkin_id
    @last_checkin_id ||= user.past_checkins.last&.id
  end
end
