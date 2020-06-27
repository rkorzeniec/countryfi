# frozen_string_literal: true

FactoryBot.define do
  factory :plain_demonym, class: Demonym do
    country_id { 1 }
    locale { 'eng' }
    gender { 'f' }
    name { 'Swiss' }
  end

  factory :demonym do
    country { build(:country) }
    locale { 'eng' }
    gender { 'f' }
    name { 'Swiss' }
  end
end
