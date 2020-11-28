# frozen_string_literal: true

class PreferencesController < ApplicationController
  before_action :preferences_form, only: %i[update]

  def edit; end

  def update
    if @preferences.save
      flash[:success] = 'Your new preferences have been saved.'
      redirect_to edit_preferences_path
    else
      flash[:error] = 'Sorry, something went wrong.'
      render :edit
    end
  end

  private

  def preferences_form
    @preferences = Users::PreferencesForm.new(current_user, user_params)
  end

  def user_params
    params.require(:user).permit(:color, :countries, :public_profile, :profile)
  end
end
