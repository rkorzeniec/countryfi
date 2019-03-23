module Checkins
  class AfricansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(african_checkins)
    end

    private

    def african_checkins
      user_checkins
        .african
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .paginate(page: params[:page], per_page: 20)
    end
  end
end
