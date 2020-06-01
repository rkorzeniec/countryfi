# frozen_string_literal: true
module Checkins
  class OceaniansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(oceanian_checkins)
    end

    private

    def oceanian_checkins
      user_checkins
        .oceanian
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .page(params[:page]).per(20)
    end
  end
end
