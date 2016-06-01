robert = User.new
robert.email = 'r.korzeniec@gmail.com'
robert.password = 'password'
robert.password_confirmation = 'password'
robert.save!

json = ActiveSupport::JSON.decode(File.read('db/seeds/countries.json'))

json.each do |a|
  # Country.create!(a[''country'], without_protection: true')
  country = Country.new

  country.name_common = a['name']['common']
  country.name_official = a['name']['official']

  a['tld'].each do |a_tld|
    tld = TopLevelDomain.new
    tld.name = a_tld
    tld.country = country
  end

  country.cca2 = a['cca2']
  country.ccn3 = a['ccn3']
  country.cca3 = a['cca3']
  country.cioc = a['cioc']

  a['currency'].each do |a_currency|
    currency = Currency.new
    currency.currency_code = a_currency
    currency.country = country
    currency.save!
  end

  country.capital = a['capital']

  a['callingCode'].each do |a_code|
    code = CountryCallingCode.new
    code.calling_code = a_code
    code.country = country
    code.save!
  end

  a['altSpellings'].each do |a_alt|
    alt = CountryAlternativeSpelling.new
    alt.name = a_alt
    alt.country = country
    alt.save!
  end

  country.region = a['region']
  country.subregion = a['subregion']

  a['languages'].each do |a_language|
    language = CountryLanguage.new
    language.name = a_language
    language.country = country
    language.save!
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
    border = CountryBorder.new
    border_country = Country.where('cca3 = ? OR cioc = ?', a_borders, a_borders).first
    border.border_country_id = border_country.id
    border.country = country
    border.save!
  end
end
