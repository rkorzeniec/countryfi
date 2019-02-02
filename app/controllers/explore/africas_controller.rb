module Explore
  class AfricasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.african, region: 'Africa'
      )
    end
  end
end
