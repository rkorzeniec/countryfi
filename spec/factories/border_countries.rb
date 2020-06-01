# frozen_string_literal: true

FactoryBot.define do
  factory :plain_border_country, class: BorderCountry do
    country_id { 1 }
    border_country_id { 2 }
  end

  factory :border_country do
    country { build(:country) }
    border_country { build(:country) }
  end
end
