# frozen_string_literal: true

module Countries
  class CallingCodesUpdater
    include UpdaterLogger

    LOG_COLUMNS = %w[country_id code].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |code_data|
        calling_code = find_or_create_by(code_data)
        update_calling_code(calling_code, code_data)
        log_update(calling_code, LOG_COLUMNS)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create_by(calling_code)
      CountryCallingCode.find_or_create_by(
        country: country, calling_code: calling_code
      )
    end

    def update_calling_code(calling_code, data)
      attrs = { calling_code: data }
      calling_code.update!(attrs)
    end
  end
end
