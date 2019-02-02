module Explore
  class EuropesController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.european, region: 'Europe'
      )
    end
  end
end
