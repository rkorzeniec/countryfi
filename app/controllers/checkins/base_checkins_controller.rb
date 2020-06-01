# frozen_string_literal: true
module Checkins
  class BaseCheckinsController < ApplicationController
    layout 'application_with_menu'

    private

    def user_checkins
      current_user.checkins
    end
  end
end
