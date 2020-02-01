module Checkins
  class EuropeansController < BaseCheckinsController
    def index
      @timeline = Checkins::TimelineFacade.new(european_checkins)
    end

    private

    def european_checkins
      user_checkins
        .european
        .joins(:country)
        .includes(:country)
        .order(checkin_date: :desc)
        .page(params[:page]).per(20)
    end
  end
end
