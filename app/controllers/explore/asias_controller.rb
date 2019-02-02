module Explore
  class AsiasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.asian, region: 'Asia'
      )
    end
  end
end
