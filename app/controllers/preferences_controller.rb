# frozen_string_literal: true

class PreferencesController < ApplicationController
  before_action :preferences_form, only: %i[update]

  def edit; end

  def update
    if @preferences.save
      flash[:success] = I18n.t('preferences.update.success')
      redirect_to edit_preferences_path, status: :see_other
    else
      flash[:error] = I18n.t('preferences.update.failure')
      render :edit, status: :unprocessable_entity
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
