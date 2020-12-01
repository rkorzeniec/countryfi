# frozen_string_literal: true

module Profile
  class CountriesCounter
    include CacheFetch

    def initialize(user)
      @user = user
    end

    def countries_count
      cache_fetch(__method__) { countries.size }
    end

    def european_countries_count
      cache_fetch(__method__) { countries.european.size }
    end

    def north_american_countries_count
      cache_fetch(__method__) { countries.north_american.size }
    end

    def south_american_countries_count
      cache_fetch(__method__) { countries.south_american.size }
    end

    def asian_countries_count
      cache_fetch(__method__) { countries.asian.size }
    end

    def african_countries_count
      cache_fetch(__method__) { countries.african.size }
    end

    def oceanian_countries_count
      cache_fetch(__method__) { countries.oceanian.size }
    end

    def antarctican_countries_count
      cache_fetch(__method__) { countries.antarctican.size }
    end

    private

    attr_reader :user

    def countries
      @countries ||= Country.send(user.countries_preference)
    end
  end
end
