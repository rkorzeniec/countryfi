# frozen_string_literal: true

module Countries
  class LanguagesUpdater
    LOG_COLUMNS = %w[country_id name code].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |language_data|
        language = find_or_create(language_data[0])
        update_language(language, language_data)
        log_update(language, LOG_COLUMNS)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create(language_code)
      CountryLanguage.find_or_create_by(country: country, code: language_code)
    end

    def update_language(language, data)
      attrs = { code: data[0], name: data[1] }
      language.update!(attrs)
    end
  end
end
