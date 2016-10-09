module CountriesHelper
  def country_code_array(countries)
    array = []
    countries.each { |country| array << country.cca2 }
    array
  end
end
