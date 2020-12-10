# frozen_string_literal: true

class UnvisitedCountriesQuery
  def initialize(user:, regions: nil, subregions: nil)
    @user = user
    @regions = regions
    @subregions = subregions
  end

  def all
    scope = Country.where.not(id: visited_countries)
    scope = region_condition(scope)
    scope = subregion_condition(scope)
    scope = independent_condition(scope)
    scope = un_condition(scope)
    scope.order('name_common')
  end

  private

  attr_reader :user, :regions, :subregions

  def visited_countries
    user.countries
  end

  def region_condition(scope)
    return scope if regions.blank?

    scope.where(region: regions)
  end

  def subregion_condition(scope)
    return scope if subregions.blank?

    scope.where(subregion: subregions) if subregions.present?
  end

  def independent_condition(scope)
    return scope unless user.independent_countries_preference?

    scope.where(independent: true)
  end

  def un_condition(scope)
    return scope unless user.un_countries_preference?

    scope.where(un_member: true)
  end
end
