# frozen_string_literal: true

module Explore
  class AntarcticasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.antarctican, region: 'Antarctica'
      )
    end
  end
end
