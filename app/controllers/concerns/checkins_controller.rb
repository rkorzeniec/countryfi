class CheckinsController < ApplicationController
  def index
    @checkins = Checkin.all
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def new
  end

  def create

  end

  def edit
  end

  def update

  end
end
