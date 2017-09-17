module Checkins
  class BaseCheckinsController < ApplicationController
    private

    def user_checkins
      current_user.checkins
    end
  end
end
