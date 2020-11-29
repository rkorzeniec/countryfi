# frozen_string_literal: true

class ProfileFacade
  include CacheFetch

  DELEGATION_METHODS = %i[
    countries_count european_countries_count north_american_countries_count
    south_american_countries_count asian_countries_count african_countries_count
    oceanian_countries_count antarctican_countries_count
  ].freeze

  delegate(*DELEGATION_METHODS, to: :countries_counter)
  delegate(*DELEGATION_METHODS, prefix: :visited, to: :visited_countries_counter)

  def initialize(user)
    @user = user
  end

  def country_counts_array
    cache_fetch(__method__) do
      visited_countries_counter.to_a
    end
  end

  def yearly_countries_chart
    @yearly_countries_chart ||= ::Profile::YearlyCountriesChartDecorator.new(user)
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
    @user_countries ||= user.countries.load
  end

  def countries_counter
    @countries_counter ||=
      ::Profile::CountriesCounter.new(user)
  end

  def visited_countries_counter
    @visited_countries_counter ||=
      ::Profile::VisitedCountriesCounter.new(user)
  end
end
