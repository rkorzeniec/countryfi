robert = User.new
robert.email = 'r.korzeniec@gmail.com'
robert.password = 'password'
robert.password_confirmation = 'password'
robert.save!

json = ActiveSupport::JSON.decode(File.read('db/seeds/countries.json'))

json.each do |a|
  country = Country.new

  country.name_common = a['name']['common']
  country.name_official = a['name']['official']

  a['tld'].each do |a_tld|
    TopLevelDomain.create!(name: a_tld, country: country)
  end

  country.cca2 = a['cca2']
  country.ccn3 = a['ccn3']
  country.cca3 = a['cca3']
  country.cioc = a['cioc']

  a['currency'].each do |a_currency|
    Currency.create!(code: a_currency, country: country)
  end

  country.capital = a['capital']

  a['callingCode'].each do |a_code|
    CountryCallingCode.create!(calling_code: a_code, country: country)
  end

  a['altSpellings'].each do |a_alt|
    CountryAlternativeSpelling.create!(name: a_alt, country: country)
  end

  country.region = a['region']
  country.subregion = a['subregion']

  a['languages'].each do |a_language|
    CountryLanguage.create!(code: a_language[0], name: a_language[1], country: country)
  end

  country.latitude = a['latlng'][0]
  country.longitude = a['latlng'][1]
  country.demonym = a['demonym']
  country.landlocked = a['landlocked']
  country.area = a['area']

  country.save!
end

json.each do |a|
  country = Country.find_by(cca3: a['cca3'])
  a['borders'].each do |a_borders|
    border_country = Country.where('cca3 = ? OR cioc = ?', a_borders, a_borders).first
    BorderCountry.create!(border_country: border_country, country: country)
  end
end
