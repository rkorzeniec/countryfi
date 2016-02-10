json = ActiveSupport::JSON.decode(File.read('db/seeds/countries.json'))

json.each do |a|
  # Country.create!(a[''country'], without_protection: true')
  c = Country.new
  c.name_common = a['name']['common']
  c.name_official = a['name']['official']
  c.name_native = a['name']['native']
  c.tld = a['tld']
  c.cca2 = a['cca2']
  c.ccn3 = a['ccn3']
  c.cca3 = a['cca3']
  c.cioc = a['cioc']
  c.currency = a['currency']
  c.capital = a['capital']
  c.callingCode = a['callingCode']
  c.altSpellings = a['altSpellings']
  c.region = a['region']
  c.subregion = a['subregion']
  c.languages = a['languages']
  c.translations = a['translations']
  c.latlng = a['latlng']
  c.demonym = a['demonym']
  c.landlocked = a['landlocked']
  c.borders = a['borders']
  c.area = a['area']

  c.save!
end
