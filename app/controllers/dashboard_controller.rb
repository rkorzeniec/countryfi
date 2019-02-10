class DashboardController < ApplicationController
  def index
    @dashboard = DashboardFacade.new(current_user)
  end
end
