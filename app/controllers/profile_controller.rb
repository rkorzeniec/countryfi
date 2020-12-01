# frozen_string_literal: true

class ProfileController < ApplicationController
  layout 'dashboard'

  skip_before_action :authenticate_user!, if: -> { params[:profile_name] }

  def show
    @user = params[:profile_name].present? ? find_user : current_user
    @profile = ProfileFacade.new(@user)
    set_flash_message
  end

  private

  def find_user
    User.find_by(public_profile: true, profile: params[:profile_name]) ||
      Users::NullUser.new
  end

  def set_flash_message
    return if params[:profile_name].blank?
    return unless @user.public_profile?

    flash[:info] = "You are visiting \"#{params[:profile_name]}\" profile"
  end
end
