# frozen_string_literal: true

module Profile
  class YearlyCountriesChartDecorator
    include CacheFetch

    def initialize(user)
      @user = user
    end

    def call
      cache_fetch(__method__) do
        [
          { name: 'all', data: all_visited_countries },
          { name: 'unique', data: unique_visited_countries }
        ]
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
