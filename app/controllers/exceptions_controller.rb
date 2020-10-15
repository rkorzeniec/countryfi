# frozen_string_literal: true

class ExceptionsController < ApplicationController
  layout 'exceptions'

  skip_before_action :authenticate_user!

  rescue_from ActionController::UnknownFormat, with: :rescue_from_unknown_format

  def index
    render status_code.to_s, status: status_code
  end

  private

  def rescue_from_unknown_format
    render nothing: true, status: :not_found
  end

  def status_code
    allowed_codes.include?(params[:code].to_s) ? params[:code] : 500
  end

  def allowed_codes
    %w[404 422 500]
  end
end
