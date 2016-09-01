class CheckinsController < ApplicationController
  before_action :authenticate_user!

  def index
    @checkins = current_user.checkins
                            .paginate(page: params[:page], per_page: 15)
                            .order(:checkin_date)
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def new
    @checkin = Checkin.new
  end

  def create
    @checkin = Checkin.new(checkin_params.merge(user: current_user))

    if @checkin.save
      flash[:success] = 'Checkin done.'
      redirect_to checkins_path
    else
      flash[:error] = 'Checkin not created.'
      render :new
    end
  end

  def edit
  end

  def update

  end

  private

  def checkin_params
    params.require(:checkin).permit(:country_id, :checkin_date)
  end
end
