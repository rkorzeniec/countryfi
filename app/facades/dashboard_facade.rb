# frozen_string_literal: true

class DashboardFacade
  CACHE_EXPIRY = 1.week

  attr_reader :countries

  def initialize(user)
    @user = user
    @countries = Country.all.load
  end

  def country_code_array
    visited_countries.pluck(:cca2)
  end

  def european_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.european
    end
  end

  def north_american_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.north_american
    end
  end

  def south_american_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.south_american
    end
  end

  def asian_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.asian
    end
  end

  def african_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.african
    end
  end

  def oceanian_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.oceanian
    end
  end

  def antarctican_countries
    Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
      countries.antarctican
    end
  end

  def visited_countries_counter
    @visited_countries_counter ||=
      ::Dashboard::VisitedCountriesCounter.new(user)
  end

  def countries_chart_data
    [
      { name: 'all', query: VisitedCountriesQuery.new(user).count_by_year },
      { name: 'unique', query: UniqVisitedCountriesQuery.new(user).count_by_year }
    ]
  end

  private

  attr_reader :user

  def visited_countries
    @visited_countries ||= user.visited_countries.load
  end

  def cache_key(method_name)
    [
      self.class.to_s.underscore,
      method_name,
      user.id,
      user.visited_checkins.last&.id
    ].compact.join('/')
  end
end
