# frozen_string_literal: true

class CheckinsController < ApplicationController
  layout 'application_with_sidebar'

  before_action :find_checkin, only: %i[show edit update destroy]
  before_action :build_checkin, only: %i[new create]

  def index
    @timeline = Checkins::TimelineFacade.new(checkins)
    respond_to :html, :json
  end

  def show
    @checkin_facade = Checkins::TimelineItemFacade.new(@checkin)
  end

  def new; end

  def create
    if @checkin.save
      flash[:success] = 'Checkin done.'
      redirect_to checkins_path, status: :see_other
    else
      flash[:error] = 'Checkin not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @checkin.update(checkin_params)
      flash[:success] = 'Checkin updated successfully'
      redirect_to checkins_path, status: :see_other
    else
      flash[:error] = 'Checkin could not be updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @checkin.destroy
      flash[:success] = 'Checkin deleted successfully'
    else
      flash[:error] = 'Checkin could not be deleted'
    end

    redirect_to checkins_path, status: :see_other
  end

  private

  def checkins
    TimelineCheckinsQuery
      .new(current_user, options: params.permit(:page, :scope))
      .query
  end

  def find_checkin
    @checkin = Checkin.find(params[:id])
  end

  def build_checkin
    @checkin = Checkin.new(checkin_params.merge(user: current_user))
  end

  def checkin_params
    params.fetch(:checkin, {}).permit(:country_id, :checkin_date)
  end
end
