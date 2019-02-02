class UnvisitedCountriesQuery
  def initialize(visited_ids, regions: nil, subregions: nil)
    @visited_ids = visited_ids
    @regions = regions
    @subregions = subregions
  end

  def countries_by(prefix = '')
    Country.where(
      'name_common LIKE :prefix' +
      visited_condition + region_condition + subregion_condition,
      prefix: prefix_with_wildcard(prefix),
      visited_ids: visited_ids,
      regions: regions,
      subregions: subregions
    ).order('name_common')
  end

  private

  attr_reader :visited_ids, :regions, :subregions

  def prefix_with_wildcard(prefix)
    prefix + '%'
  end

  def visited_condition
    return '' if visited_ids.empty?
    ' AND id NOT IN (:visited_ids)'
  end

  def region_condition
    return '' unless regions
    ' AND region IN (:regions)'
  end

  def subregion_condition
    return '' unless subregions
    ' AND subregion IN (:subregions)'
  end
end
