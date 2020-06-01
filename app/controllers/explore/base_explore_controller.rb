# frozen_string_literal: true

module Explore
  class BaseExploreController < ApplicationController
    layout 'application_with_menu'

    private

    def visited_countries
      current_user.visited_countries
    end
  end
end
