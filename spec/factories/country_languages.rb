# frozen_string_literal: true

FactoryBot.define do
  factory :plain_country_language, class: CountryLanguage do
    country_id { 1 }
    name { 'English' }
    code { 'eng' }
  end

  factory :country_language do
    country { build(:country) }
    name { 'English' }
    code { 'eng' }
  end
end
