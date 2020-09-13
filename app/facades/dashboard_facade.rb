# frozen_string_literal: true

class DashboardFacade
  include CacheFetch

  def initialize(user)
    @user = user
  end

  def country_code_array
    cache_fetch(__method__) { user_countries.pluck(:cca2) }
  end

  def countries_count
    cache_fetch(__method__) { countries.size }
  end

  def european_countries_count
    cache_fetch(__method__) { countries.european.size }
  end

  def north_american_countries_count
    cache_fetch(__method__) { countries.north_american.size }
  end

  def south_american_countries_count
    cache_fetch(__method__) { countries.south_american.size }
  end

  def asian_countries_count
    cache_fetch(__method__) { countries.asian.size }
  end

  def african_countries_count
    cache_fetch(__method__) { countries.african.size }
  end

  def oceanian_countries_count
    cache_fetch(__method__) { countries.oceanian.size }
  end

  def antarctican_countries_count
    cache_fetch(__method__) { countries.antarctican.size }
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
      TopCountriesQuery.new(user_countries).query
    end
  end

  def top_regions_chart_data
    cache_fetch(__method__) do
      TopRegionsQuery.new(user_countries).query
    end
  end

  private

  attr_reader :user

  def user_countries
    @user_countries ||= user.countries.distinct
  end

  def countries
    @countries ||= Country.send(user.countries_preference).load
  end

  def last_checkin_id
    @last_checkin_id ||= user.past_checkins.last&.id
  end
end
