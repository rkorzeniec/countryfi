class CheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:show, :index]

  def index
    @checkins = Checkin.all
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def new
    @checkin = Checkin.new
  end

  def create
    @checkin = Checkin.new(checkin_params)

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to root_url, notice: 'Checkin done...' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update

  end

  private

  def checkin_params
      params.require(:checkin).permit(:country, :checkin_date)
    end
end
