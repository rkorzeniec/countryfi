FactoryGirl.define do
  factory :country do
    name_common 'Switzerland'
    name_official 'Swiss Confederation'
    cca2 'CH'
    ccn3 '756'
    cca3 'CHE'
    cioc 'SUI'
    capital 'Bern'
    region 'Europe'
    subregion 'Western Europe'
    demonym 'Swiss'
    landlocked true
    area 41_284
    latitude 47
    longitude 8
  end
end
