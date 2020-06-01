# frozen_string_literal: true
module Checkins
  class NorthAmericansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(north_american_checkins)
    end

    private

    def north_american_checkins
      user_checkins
        .north_american
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .page(params[:page]).per(20)
    end
  end
end
