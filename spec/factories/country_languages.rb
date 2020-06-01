# frozen_string_literal: true
FactoryBot.define do
  factory :country_language do
    country_id { 1 }
    name { 'English' }
    code { 'eng' }
  end
end
