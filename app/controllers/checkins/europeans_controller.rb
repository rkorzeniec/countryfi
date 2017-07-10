module Checkins
  class EuropeansController < BaseCheckinsController
    layout 'application_with_menu'

    def index
      @checkins = european_checkins
                  .paginate(page: params[:page], per_page: 15)
                  .order(checkin_date: :desc)
    end

    private

    def european_checkins
      user_checkins.european
    end
  end
end
