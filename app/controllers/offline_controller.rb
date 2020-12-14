# frozen_string_literal: true

class OfflineController < ApplicationController
  skip_before_action :authenticate_user!

  def index; end
end
