# frozen_string_literal: true

module Checkins
  class TimelineItemFacade
    attr_reader :checkin

    delegate :country, :to_key, :model_name, to: :checkin
    delegate :flag_image_path, to: :country
    delegate :cca2, to: :country, prefix: true

    def initialize(checkin)
      @checkin = checkin
    end

    def checkin_date
      @checkin_date ||= checkin.checkin_date.strftime('%Y-%m-%d')
    end

    def checkin_year
      @checkin_year ||= checkin.checkin_date.year
    end

    def country_common_name
      country.name_common
    end
  end
end
