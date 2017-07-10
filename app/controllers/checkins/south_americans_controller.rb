module Checkins
  class SouthAmericansController < BaseCheckinsController
    def index
      @checkins = south_american_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def south_american_checkins
      user_checkins.south_american
    end
  end
end
