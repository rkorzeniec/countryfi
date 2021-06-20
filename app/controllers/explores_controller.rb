# frozen_string_literal: true

class ExploresController < ApplicationController
  layout 'application_with_sidebar'

  def index
    @explore_facade = ExploreFacade.new(user: current_user, scope: params[:scope])
  end
end
