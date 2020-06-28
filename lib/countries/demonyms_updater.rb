# frozen_string_literal: true

module Countries
  class DemonymsUpdater
    include ::Countries::UpdaterLogger

    LOG_COLUMNS = %w[country_id locale gender name].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |demonym_data|
        demonym_data[1].each do |gender, name|
          next if gender.blank? || name.blank?

          locale = demonym_data[0]
          handle_demonym_per_gender(locale, gender, name)
        end
      end
    end

    private

    attr_reader :country, :data

    def handle_demonym_per_gender(locale, gender, name)
      demonym = find_or_create_by(locale, gender)
      update_demonym(demonym, locale, gender, name)
      log_update(demonym, LOG_COLUMNS)
    end

    def find_or_create_by(locale, gender)
      Demonym.find_or_create_by(
        country: country, locale: locale, gender: gender
      )
    end

    def update_demonym(demonym, locale, gender, name)
      attrs = { locale: locale, gender: gender, name: name }
      demonym.update!(attrs)
    end
  end
end
