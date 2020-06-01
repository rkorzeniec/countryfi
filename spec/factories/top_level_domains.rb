# frozen_string_literal: true

FactoryBot.define do
  factory :plain_top_level_domain, class: TopLevelDomain do
    country_id { 1 }
    name { 'ch' }
  end

  factory :top_level_domain do
    country { build(:country) }
    name { 'ch' }
  end
end
