module Checkins
  class OceaniansController < BaseCheckinsController
    def index
      @checkins = oceanian_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def oceanian_checkins
      user_checkins.oceanian
    end
  end
end
