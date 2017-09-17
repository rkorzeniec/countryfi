module CountriesHelper
  def country_code_array(countries)
    countries.map(&:cca2)
  end
end
