# frozen_string_literal: true

module Explore
  class BaseExploreController < ApplicationController
    layout 'application_with_sidebar'

    def index
      @explore_facade = ExploreFacade.new(
        user: current_user, region: region, subregions: subregions
      )
    end

    private

    def region
      raise NotImplementedError, 'must provide region'
    end

    def subregions
      nil
    end
  end
end
