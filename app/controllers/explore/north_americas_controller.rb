# frozen_string_literal: true

module Explore
  class NorthAmericasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.north_american,
        region: 'Americas',
        subregions: ['North America', 'Central America', 'Caribbean']
      )
    end
  end
end
