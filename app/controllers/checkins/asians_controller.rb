module Checkins
  class AsiansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(asian_checkins)
    end

    private

    def asian_checkins
      user_checkins
        .asian
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .paginate(page: params[:page], per_page: 20)
    end
  end
end
