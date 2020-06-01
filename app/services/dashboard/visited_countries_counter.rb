# frozen_string_literal: true
module Dashboard
  class VisitedCountriesCounter
    CACHE_EXPIRY = 1.week

    def initialize(user)
      @user = user
    end

    def visited_world_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins)
      end
    end

    def visited_european_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.european)
      end
    end

    def visited_north_american_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.north_american)
      end
    end

    def visited_south_american_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.south_american)
      end
    end

    def visited_asian_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.asian)
      end
    end

    def visited_oceanian_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.oceanian)
      end
    end

    def visited_african_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.african)
      end
    end

    def visited_antarctican_countries_count
      Rails.cache.fetch(cache_key(__method__), expires_in: CACHE_EXPIRY) do
        uniq_visited_count(visited_checkins.antarctican)
      end
    end

    private

    attr_reader :user

    def visited_checkins
      @visited_checkins ||= user.visited_countries
    end

    def uniq_visited_count(countries)
      Set.new(countries).size
    end

    def cache_key(method_name)
      [
        self.class.to_s.underscore,
        method_name,
        user.id,
        user.visited_checkins.last&.id
      ].compact.join('/')
    end
  end
end
