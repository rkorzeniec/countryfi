class CountryNameLookuper
  attr_reader :country_code

  def initialize(code)
    @country_code = code
  end

  def lookup
    Country.find_by(cca2: country_code).name_common
  end
end
