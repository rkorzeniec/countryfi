# frozen_string_literal: true

module Countries
  class TldsUpdater
    LOG_COLUMNS = %w[country_id name].freeze

    def initialize(country:, data:)
      @country = country
      @data = data
    end

    def call
      data.each do |tld_data|
        tld = find_or_create(tld_data)
        update_tld(tld, tld_data)
        log_update(tld, LOG_COLUMNS)
      end
    end

    private

    attr_reader :country, :data

    def find_or_create(tld)
      TopLevelDomain.find_or_create_by(country: country, name: tld)
    end

    def update_tld(tld, data)
      attrs = { name: data }
      tld.update!(attrs)
    end
  end
end
