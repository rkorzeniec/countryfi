module Explore
  class WorldsController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(visited_countries)
    end
  end
end
