# frozen_string_literal: true

module Explore
  class OceaniasController < BaseExploreController
    def index
      @explore_facade = ExploreFacade.new(
        visited_countries.oceanian, region: 'Oceania'
      )
    end
  end
end
