class PreferencesController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Your new preferences have been saved.'
      redirect_to edit_preferences_path
    else
      flash[:error] = 'Sorry, something went wrong.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:color)
  end
end
