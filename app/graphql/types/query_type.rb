module Types
  class QueryType < Types::BaseObject
    field :checkins, [Types::CheckinType], null: false
    field :me, Types::UserType, null: false

    def checkins
      Checkin.all
    end

    def me
      context[:current_user]
    end
  end
end
