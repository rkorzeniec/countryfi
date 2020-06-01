# frozen_string_literal: true

FactoryBot.define do
  factory :plain_country_alternative_spelling, class: CountryAlternativeSpelling do
    country_id { 1 }
    name { 'Country' }
  end

  factory :country_alternative_spelling do
    country { build(:country) }
    name { 'Country' }
  end
end
