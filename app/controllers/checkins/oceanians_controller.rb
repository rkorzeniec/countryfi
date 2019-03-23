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
        .paginate(page: params[:page], per_page: 20)
    end
  end
end
