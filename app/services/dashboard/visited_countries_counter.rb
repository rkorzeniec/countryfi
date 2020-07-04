# frozen_string_literal: true

module Dashboard
  class VisitedCountriesCounter
    CACHE_EXPIRY = 1.week

    def initialize(user)
      @user = user
    end

    def visited_world_countries_count
      cache_fetch(__method__) { uniq_visited_count(calculable_checkins) }
    end

    def visited_european_countries_count
      cache_fetch(__method__) { uniq_visited_count(calculable_checkins) }
    end

    def visited_north_american_countries_count
      cache_fetch(__method__) do
        uniq_visited_count(calculable_checkins.north_american)
      end
    end

    def visited_south_american_countries_count
      cache_fetch(__method__) do
        uniq_visited_count(calculable_checkins.south_american)
      end
    end

    def visited_asian_countries_count
      cache_fetch(__method__) { uniq_visited_count(calculable_checkins.asian) }
    end

    def visited_oceanian_countries_count
      cache_fetch(__method__) { uniq_visited_count(calculable_checkins.oceanian) }
    end

    def visited_african_countries_count
      cache_fetch(__method__) { uniq_visited_count(calculable_checkins.african) }
    end

    def visited_antarctican_countries_count
      cache_fetch(__method__) do
        uniq_visited_count(calculable_checkins.antarctican)
      end
    end

    private

    attr_reader :user

    def calculable_checkins
      @calculable_checkins ||= user.visited_countries
    end

    def cache_fetch(method_name)
      Rails.cache.fetch(cache_key(method_name), expires_in: CACHE_EXPIRY) do
        Rails.logger.info(cache_key(method_name))
        yield
      end
    end

    def uniq_visited_count(countries)
      Set.new(countries).size
    end

    def cache_key(method_name)
      [
        self.class.to_s.underscore,
        method_name,
        user.id,
        last_checkin_id
      ].compact.join('/')
    end

    def last_checkin_id
      @last_checkin_id ||= user.calculable_checkins.last&.id
    end
  end
end
