# frozen_string_literal: true

module Types
  class CheckinType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: true
    field :country, Types::CountryType, null: true
    field :checkin_date, String, null: true
  end
end
