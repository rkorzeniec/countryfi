# frozen_string_literal: true

module Checkins
  class BaseCheckinsController < ApplicationController
    layout 'application_with_sidebar'

    respond_to :html, :json

    private

    def user_checkins
      current_user.checkins
    end
  end
end
