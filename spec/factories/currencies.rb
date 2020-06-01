# frozen_string_literal: true

FactoryBot.define do
  factory :plain_currency, class: CountryLanguage do
    country_id { 1 }
    code { 'CHF' }
  end

  factory :currency do
    country { build(:country) }
    code { 'CHF' }
  end
end
