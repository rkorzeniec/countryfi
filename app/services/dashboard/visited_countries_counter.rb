# frozen_string_literal: true

module Dashboard
  class VisitedCountriesCounter
    CACHE_EXPIRY = 1.week

    def initialize(user)
      @user = user
    end

    def visited_world_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries) }
    end

    def visited_european_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.european) }
    end

    def visited_north_american_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.north_american) }
    end

    def visited_south_american_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.south_american) }
    end

    def visited_asian_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.asian) }
    end

    def visited_oceanian_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.oceanian) }
    end

    def visited_african_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.african) }
    end

    def visited_antarctican_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.antarctican) }
    end

    private

    attr_reader :user

    def countries
      @countries ||= user.visited_countries
    end

    def uniq_countries_count(countries)
      Set.new(countries).size
    end

    def cache_fetch(method_name)
      Rails.cache.fetch(cache_key(method_name), expires_in: CACHE_EXPIRY) do
        Rails.logger.info(cache_key(method_name))
        yield
      end
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
      @last_checkin_id ||= user.checkins.last&.id
    end
  end
end
