# frozen_string_literal: true

module Explore
  class NorthAmericasController < BaseExploreController
    private

    def region
      'Americas'
    end

    def subregions
      ['North America', 'Central America', 'Caribbean']
    end
  end
end
