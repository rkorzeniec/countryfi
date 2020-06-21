# frozen_string_literal: true

class NotificationsController < ApplicationController
  respond_to :json

  def index
    @notifications = Notification
      .includes(:notifiable)
      .where(recipient: current_user)
      .unread
  end
end
