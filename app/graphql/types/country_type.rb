# frozen_string_literal: true

module Types
  class CountryType < Types::BaseObject
    field :name_common, String, null: false
    field :name_official, String, null: true
    field :cca2, String, null: true
    field :ccn3, String, null: true
    field :cca3, String, null: true
    field :capital, String, null: true
  end
end
