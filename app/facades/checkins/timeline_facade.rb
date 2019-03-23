module Checkins
  class TimelineFacade
    delegate :total_pages, :current_page, :next_page, to: :checkins

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
      @current_time ||= Time.current
    end
  end
end
