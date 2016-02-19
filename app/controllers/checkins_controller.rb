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
  end

  def edit
  end

  def update

  end
end
