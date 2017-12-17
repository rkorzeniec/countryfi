module Checkins
  class AntarcticansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(antarctican_checkins)
    end

    private

    def antarctican_checkins
      user_checkins.antarctican
                   .joins(:country)
                   .includes(:country)
                   .order(checkin_date: :desc)
    end
  end
end
