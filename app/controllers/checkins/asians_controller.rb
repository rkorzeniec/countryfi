module Checkins
  class AsiansController < BaseCheckinsController
    def index
      @checkins = asian_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def asian_checkins
      user_checkins.asian
    end
  end
end
