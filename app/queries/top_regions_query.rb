# frozen_string_literal: true

class TopRegionsQuery
  def initialize(visited_countries)
    @visited_countries = visited_countries
  end

  def query
    visited_countries
      .group('countries.subregion')
      .limit(7)
      .order('COUNT(countries.subregion) DESC')
      .count
  end

  private

  attr_reader :visited_countries
end
