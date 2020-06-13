# frozen_string_literal: true

class HelloController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_authenticated

  def index; end

  private

  def redirect_authenticated
    return unless current_user

    redirect_to dashboard_path
  end
end
