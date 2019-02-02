class ExploreFacade
  def initialize(visited_countries, region: nil, subregions: nil)
    @visited_countries = visited_countries
    @region = region
    @subregions = subregions
  end

  def discoverable_countries(letter)
    unvisited_countries.countries_by(letter)
  end

  private

  attr_reader :visited_countries, :region, :subregions

  def unvisited_countries
    @unvisited_countries ||= UnvisitedCountriesQuery.new(
      visited_country_ids, regions: region, subregions: subregions
    )
  end

  def visited_country_ids
    return [] if visited_countries.nil?
    visited_countries.pluck(:id)
  end
end
