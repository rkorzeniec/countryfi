# frozen_string_literal: true

module Checkins
  class WorldsController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(world_checkins)
    end

    private

    def world_checkins
      user_checkins
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .page(params[:page]).per(20)
    end
  end
end
