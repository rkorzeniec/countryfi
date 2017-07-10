module Checkins
  class WorldsController < BaseCheckinsController
    def index
      @checkins = user_checkins.paginate(page: params[:page], per_page: 15)
                               .order(checkin_date: :desc)
    end
  end
end
