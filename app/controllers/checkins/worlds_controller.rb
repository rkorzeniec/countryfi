module Checkins
  class WorldsController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(checkins)
    end

    private

    def checkins
      user_checkins.joins(:country).includes(:country).order(checkin_date: :desc)
    end
  end
end
