module Checkins
  class TimelineFacade
    def initialize(checkins)
      @checkins = checkins
    end

    def items
      @_items = checkins.map do |checkin|
        TimelineItemFacade.new(checkin)
      end
    end

    def today_marker?(index)
      return if items[index + 1].nil?
      items[index].checkin_date > current_time &&
        items[index + 1].checkin_date <= current_time
    end

    def year_marker?(index)
      return if items[index + 1].nil?
      items[index].checkin_year != items[index + 1].checkin_year
    end

    def future_checkin?(index)
      items[index].checkin_date > current_time
    end

    private

    attr_reader :checkins

    def current_time
      @_current_time ||= Time.current
    end
  end
end
