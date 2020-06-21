# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :fetch_notifications

  respond_to :json, :js

  def index; end

  def mark_as_read
    if params[:id]
      @notification = Notification.find(params[:id])
      @notification.update(read_at: Time.current)
    else
      #rubocop:disable Rails/SkipsModelValidations
      @notifications.update_all(read_at: Time.current)
      #rubocop:enable Rails/SkipsModelValidations
    end
  end

  private

  def fetch_notifications
    @notifications = Notification
      .includes(:notifiable)
      .where(recipient: current_user)
      .unread
  end
end
