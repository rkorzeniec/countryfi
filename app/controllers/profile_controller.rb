# frozen_string_literal: true

class ProfileController < ApplicationController
  layout 'dashboard'

  skip_before_action :authenticate_user!, if: -> { params[:profile_name] }

  def show
    @user = params[:profile_name].present? ? find_user : current_user
    @profile = ProfileFacade.new(@user)
    flash[:info] = profile_message if params[:profile_name].present?
    # add overlay to profile page, saying that profile is unneccesssible
    # (could also be used for PWA offline view?)
  end

  private

  def find_user
    User.find_by(public_profile: true, profile: params[:profile_name]) ||
      Users::NullUser.new
  end

  def profile_message
    "You are visiting \"#{params[:profile_name]}\" profile"
  end
end
