json = ActiveSupport::JSON.decode(File.read('db/seeds/countries.json'))

json.each do |a|
  Country.create!(a['country'], without_protection: true)
end
