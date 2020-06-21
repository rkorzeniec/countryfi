# frozen_string_literal: true

module Admin
  class AnnouncementsController < Admin::ApplicationController
    def create
      announcement = Announcement.new(resource_params)
      authorize_resource(announcement)

      if announcement.save
        Admin::AnnouncementNotificationsCreator.new(announcement).delay.call
        handle_success(announcement)
      else
        handle_error(announcement)
      end
    end

    private

    def handle_success(announcement)
      redirect_to(
        [namespace, announcement],
        notice: translate_with_resource('create.success')
      )
    end

    def handle_error(announcement)
      render :new, locals: {
        page: Administrate::Page::Form.new(dashboard, announcement)
      }
    end
  end
end
