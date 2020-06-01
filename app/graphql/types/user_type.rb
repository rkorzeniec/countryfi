# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :checkins, [Types::CheckinType], null: true
    field :countries, [Types::CountryType], null: true
  end
end
