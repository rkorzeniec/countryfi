# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_sentry_context
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :control_rack_mini_profiler

  helper_method :current_controller?

  def after_sign_in_path_for(_resource)
    profile_path
  end

  def control_rack_mini_profiler
    Rack::MiniProfiler.authorize_request if current_user&.admin? && params[:rmp]
  end

  def current_controller?(names)
    return false if params[:controller].blank?

    names.include?(params[:controller])
  end

  private

  def set_sentry_context
    Sentry.set_user(id: session[:current_user_id])
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end

  def set_current_user
    Current.user = current_user || NullUser.new
  end
end
