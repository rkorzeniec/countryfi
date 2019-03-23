module Checkins
  class TimelineItemFacade
    attr_reader :checkin

    delegate :country, to: :checkin

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

    def country_cca2
      country.cca2
    end

    def flag_image_path
      country.flag_image_path
    end
  end
end
