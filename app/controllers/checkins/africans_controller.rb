module Checkins
  class AfricansController < BaseCheckinsController
    def index
      @checkins = african_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def african_checkins
      user_checkins.african
    end
  end
end
