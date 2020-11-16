# frozen_string_literal: true

module Dashboard
  class VisitedCountriesCounter
    include CacheFetch

    def initialize(user)
      @user = user
    end

    def to_a
      cache_fetch(__method__) do
        user.countries.pluck(:cca2).each_with_object(Hash.new(0)) do |result, hash|
          hash[result] += 1
        end.to_a
      end
    end

    def countries_count
      cache_fetch(__method__) { uniq_countries_count(countries) }
    end

    def european_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.european) }
    end

    def north_american_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.north_american) }
    end

    def south_american_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.south_american) }
    end

    def asian_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.asian) }
    end

    def oceanian_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.oceanian) }
    end

    def african_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.african) }
    end

    def antarctican_countries_count
      cache_fetch(__method__) { uniq_countries_count(countries.antarctican) }
    end

    private

    attr_reader :user

    def countries
      @countries ||= user.countries.distinct
    end

    def uniq_countries_count(countries)
      Set.new(countries).size
    end
  end
end
