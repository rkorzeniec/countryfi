# frozen_string_literal: true
class UnvisitedCountriesQuery
  def initialize(visited_countries, regions: nil, subregions: nil)
    @visited_countries = visited_countries
    @regions = regions
    @subregions = subregions
  end

  def all
    Country
      .where.not(id: visited_countries)
      .where(
        %(#{region_condition} #{subregion_condition}),
        regions: regions,
        subregions: subregions
      ).order('name_common')
  end

  private

  attr_reader :visited_countries, :regions, :subregions

  def region_condition
    return '' unless regions
    ' region IN (:regions)'
  end

  def subregion_condition
    return '' unless subregions
    ' AND subregion IN (:subregions)'
  end
end
