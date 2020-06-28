# frozen_string_literal: true

module Countries
  class CurrenciesUpdater
    include UpdaterLogger

    LOG_COLUMNS = %w[country_id code name symbol].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |currency_data|
        currency = find_or_create_by(currency_data)
        update_currency(currency, currency_data)
        log_update(currency, LOG_COLUMNS)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create_by(currency)
      Currency.find_or_create_by(country: country, code: currency[0])
    end

    def update_currency(currency, data)
      attrs = { code: data[0], symbol: data[1][:symbol], name: data[1][:name] }
      currency.update!(attrs)
    end
  end
end
