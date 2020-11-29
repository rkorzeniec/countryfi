# frozen_string_literal: true

module Profile
  class YearlyCountriesChartDecorator
    include CacheFetch

    def initialize(user)
      @user = user
    end

    def labels
      cache_fetch(__method__) do
        all_visited_countries.keys | unique_visited_countries.keys
      end
    end

    def series
      cache_fetch(__method__) do
        [all_visited_countries.values, unique_visited_countries.values]
      end
    end

    private

    attr_reader :user

    def all_visited_countries
      @all_visited_countries ||= VisitedCountriesQuery.new(user).count_by_year
    end

    def unique_visited_countries
      @unique_visited_countries ||= UniqVisitedCountriesQuery.new(user).count_by_year
    end
  end
end
