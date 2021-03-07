# frozen_string_literal: true

class ServiceWorkerController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def service_worker; end

  def manifest; end
end
