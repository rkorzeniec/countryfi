module Checkins
  class AntarcticansController < BaseCheckinsController
    def index
      @checkins = antarctican_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def antarctican_checkins
      user_checkins.antarctican
    end
  end
end
