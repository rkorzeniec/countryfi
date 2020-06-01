# frozen_string_literal: true

module Explore
  class SouthAmericasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.south_american,
        region: 'Americas',
        subregions: 'South America'
      )
    end
  end
end
