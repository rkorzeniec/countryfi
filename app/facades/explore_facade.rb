# frozen_string_literal: true

class ExploreFacade
  def initialize(user:, region: nil, subregions: nil)
    @user = user
    @region = region
    @subregions = subregions
  end

  def discoverable_countries
    @discoverable_countries ||= unvisited_countries.all.load
  end

  def discoverable_countries_by_category(category = 'All')
    return discoverable_countries if category == 'All'

    discoverable_countries.select do |country|
      country.name_common.first == category
    end
  end

  def country_categories
    ['All', *discoverable_countries.map(&:name_common).map(&:first).uniq]
  end

  private

  attr_reader :user, :region, :subregions

  def unvisited_countries
    UnvisitedCountriesQuery.new(
      user: user,
      regions: region,
      subregions: subregions
    )
  end
end
