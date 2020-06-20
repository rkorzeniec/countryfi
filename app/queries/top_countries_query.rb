# frozen_string_literal: true

class TopCountriesQuery
  def initialize(visited_countries)
    @visited_countries = visited_countries
  end

  def query
    visited_countries
      .group('countries.cca2')
      .limit(7)
      .order('COUNT(countries.cca2) DESC')
      .count
  end

  private

  attr_reader :visited_countries
end
