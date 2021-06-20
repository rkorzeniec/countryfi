# frozen_string_literal: true

class ExploreFacade
  def initialize(user:, scope: nil)
    @user = user
    @scope = scope
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

  attr_reader :user, :scope

  def unvisited_countries
    UnvisitedCountriesQuery.new(
      user: user,
      regions: region,
      subregions: subregions
    )
  end

  def region
    return unless scope
    return 'Americas' if %w[north_america south_america].include?(scope)

    scope.capitalize
  end

  def subregions
    case scope
    when 'north_america' then ['North America', 'Central America', 'Caribbean']
    when 'south_america' then 'South America'
    when 'europe', 'asia', 'africa', 'oceania', 'antarctica' then nil
    end
  end
end
