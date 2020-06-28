# frozen_string_literal: true

FactoryBot.define do
  factory :plain_currency, class: CountryLanguage do
    country_id { 1 }
    code { 'CHF' }
    symbol { 'Fr.' }
    name { 'Swiss franc' }
  end

  factory :currency do
    country { build(:country) }
    code { 'CHF' }
    symbol { 'Fr.' }
    name { 'Swiss franc' }
  end
end
