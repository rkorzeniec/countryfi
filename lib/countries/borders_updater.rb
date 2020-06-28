# frozen_string_literal: true

module Countries
  class BordersUpdater
    include UpdaterLogger

    LOG_COLUMNS = %w[country_id border_country_id].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |border|
        neighbour_country = find_or_create_neighbour_country(border)
        create_border(neighbour_country)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create_neighbour_country(border)
      Country.find_or_create_by(cca3: border)
    end

    def create_border(border_country)
      BorderCountry.find_or_create_by(
        country: country, border_country: border_country
      )
    end
  end
end
