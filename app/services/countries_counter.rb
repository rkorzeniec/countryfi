# frozen_string_literal: true
class CountriesCounter
  class << self
    def world_countries_count
      Country.count
    end

    def european_countries_count
      Country.european.count
    end

    def north_american_countries_count
      Country.north_american.count
    end

    def south_american_countries_count
      Country.south_american.count
    end

    def asian_countries_count
      Country.asian.count
    end

    def oceanian_countries_count
      Country.oceanian.count
    end

    def african_countries_count
      Country.african.count
    end

    def antarctican_countries_count
      Country.antarctican.count
    end
  end
end
