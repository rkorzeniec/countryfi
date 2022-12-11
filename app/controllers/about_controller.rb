# frozen_string_literal: true

class AboutController < ApplicationController
  skip_before_action :authenticate_user!

  layout 'hero'

  def index; end
end
