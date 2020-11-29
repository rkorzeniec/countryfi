# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_raven_context
  before_action :authenticate_user!
  before_action :control_rack_mini_profiler

  def after_sign_in_path_for(_resource)
    profile_path
  end

  def control_rack_mini_profiler
    Rack::MiniProfiler.authorize_request if current_user&.admin? && params[:rmp]
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
