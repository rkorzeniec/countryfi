# frozen_string_literal: true

module Countries
  class AltSpellingsUpdater
    include UpdaterLogger

    LOG_COLUMNS = %w[country_id name].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |spelling_data|
        alt_spelling = find_or_create_by(spelling_data)
        update_alt_spelling(alt_spelling, spelling_data)
        log_update(alt_spelling)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create_by(alt_spelling)
      CountryAlternativeSpelling.find_or_create_by(
        country: country, name: alt_spelling
      )
    end

    def update_alt_spelling(alt_spelling, data)
      attrs = { name: data }
      alt_spelling.update!(attrs)
    end
  end
end
