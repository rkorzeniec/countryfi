module Checkins
  class NorthAmericansController < BaseCheckinsController
    def index
      @checkins = north_american_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def north_american_checkins
      user_checkins.north_american
    end
  end
end
