# frozen_string_literal: true

module Profile
  class AvailabilitiesController < ApplicationController
    respond_to :json, :js

    def show
      availability = User.where(profile: params[:profile]).empty?

      render json: { availability: availability }.to_json
    end
  end
end
