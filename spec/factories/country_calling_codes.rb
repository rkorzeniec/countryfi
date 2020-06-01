# frozen_string_literal: true

FactoryBot.define do
  factory :plain_country_calling_code, class: CountryCallingCode do
    country_id { 1 }
    calling_code { '+41' }
  end

  factory :country_calling_code do
    country { build(:country) }
    calling_code { '+41' }
  end
end
