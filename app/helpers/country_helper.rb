module CountryHelper
  def country_field_labels
    [
      'Official Name', 'Common Name', 'Native Name(s)', 'Capital City',
      'Demonym', 'Languages', 'Region', 'Subregion', 'Currency', 'Calling Code',
      'Geo Coordinates', 'Landlocked', 'Borders', 'Area (km^2)',
      'Top Level Domain', 'Country Code Alpha 2', 'Country Code Numeric',
      'Country Code Alpha 3', 'International Olympic Committee Code',
      'Alternative Spellings', 'Translations'
    ]
  end

  def county_field_values(country)
    [
      country.name_official, country.name_common,
      country.name_native, country.capital, country.demonym, country.languages,
      country.region, country.subregion, country.currency, country.callingCode,
      country.latlng, country.landlocked, country.borders, country.area,
      country.tld, country.cca2, country.ccn3, country.cca3, country.cioc,
      country.altSpellings, country.translations
    ]
  end

  def all_countries
    Country.all
  end

  def country_code_array(countries)
    array = []
    countries.each { |country| array << country.cca2 }
    array
  end
end
