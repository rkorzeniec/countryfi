# frozen_string_literal: true

module Countries
  class Updater
    include UpdaterLogger

    LOG_COLUMNS = %w[
      name_common name_official cca2 ccn3 cca3 cioc independent status
      capital region subregion latitude longitude area flag
    ].freeze

    def initialize(data)
      @data = data
    end

    def call
      find_or_create
      update_country
      update_associations
      log_update(country)
    end

    private

    attr_reader :data, :country

    def find_or_create
      @country = Country.find_or_create_by(cca3: data['cca3'])
    end

    def update_country
      country.update!(country_attributes)
    end

    def country_attributes
      {
        name_common: data['name']['common'],
        name_official: data['name']['official'],
        cca2: data['cca2'],
        ccn3: data['ccn3'],
        cca3: data['cca3'],
        cioc: data['cioc'],
        independent: data['independent'],
        status: data['status'],
        capital: data['capital'].first,
        region: data['region'],
        subregion: data['subregion'],
        latitude: data['latlng'].first,
        longitude: data['latlng'].second,
        area: data['area'],
        # flag: data['flag']
      }
    end

    def update_associations
      update_tlds
      update_currencies
      update_country_calling_codes
      update_country_alternative_spellings
      update_country_languages
      update_country_demonyms
      update_borders
    end

    def update_tlds
      TldsUpdater.new(country: country, data: data['tld']).call
    end

    def update_currencies
      CurrenciesUpdater.new(country: country, data: data['currencies']).call
    end

    def update_country_calling_codes
      CallingCodesUpdater.new(country: country, data: data['callingCodes']).call
    end

    def update_country_alternative_spellings
      AltSpellingsUpdater.new(country: country, data: data['altSpellings']).call
    end

    def update_country_languages
      LanguagesUpdater.new(country: country, data: data['languages']).call
    end

    def update_country_demonyms
      DemonymsUpdater.new(country: country, data: data['demonyms']).call
    end

    def update_borders
      Countries::BordersUpdater.new(country: country, data: data['borders']).call
    end
  end
end
