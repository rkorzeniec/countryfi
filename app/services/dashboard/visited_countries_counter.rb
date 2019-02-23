module Dashboard
  class VisitedCountriesCounter
    def initialize(user)
      @user = user
    end

    def visited_world_countries_count
      uniq_visited_count(visited_checkins)
    end

    def visited_european_countries_count
      uniq_visited_count(visited_checkins.european)
    end

    def visited_north_american_countries_count
      uniq_visited_count(visited_checkins.north_american)
    end

    def visited_south_american_countries_count
      uniq_visited_count(visited_checkins.south_american)
    end

    def visited_asian_countries_count
      uniq_visited_count(visited_checkins.asian)
    end

    def visited_oceanian_countries_count
      uniq_visited_count(visited_checkins.oceanian)
    end

    def visited_african_countries_count
      uniq_visited_count(visited_checkins.african)
    end

    def visited_antarctican_countries_count
      uniq_visited_count(visited_checkins.antarctican)
    end

    private

    attr_reader :user

    def visited_checkins
      @visited_checkins ||= user.visited_countries
    end

    def uniq_visited_count(countries)
      Set.new(countries).size
    end
  end
end
