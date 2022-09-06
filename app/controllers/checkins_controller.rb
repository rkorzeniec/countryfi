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
    checkin_facade = Checkins::TimelineItemFacade.new(@checkin)
    render partial: 'checkin_item', locals: { checkin_facade: checkin_facade }
  end

  def new
    render partial: 'new'
  end

  def create
    if @checkin.save
      @checkin_facade = Checkins::TimelineItemFacade.new(@checkin)
      flash[:success] = I18n.t('checkins.create.success')
    else
      flash[:error] = I18n.t('checkins.create.error')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    render partial: 'edit'
  end

  def update
    @checkin.update!(checkin_params)
    @checkin_facade = Checkins::TimelineItemFacade.new(@checkin)

    flash[:success] = I18n.t('checkins.update.success')
  end

  def destroy
    @checkin.destroy!
    flash[:success] = I18n.t('checkins.destroy.success')
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
