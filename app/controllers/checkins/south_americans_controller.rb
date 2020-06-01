# frozen_string_literal: true

module Checkins
  class SouthAmericansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(south_american_checkins)
    end

    private

    def south_american_checkins
      user_checkins
        .south_american
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .page(params[:page]).per(20)
    end
  end
end
