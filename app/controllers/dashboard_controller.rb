class DashboardController < ApplicationController
  layout 'dashboard'

  def index
    @dashboard = DashboardFacade.new(current_user)
  end
end
