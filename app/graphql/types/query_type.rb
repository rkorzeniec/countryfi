# frozen_string_literal: true
module Types
  class QueryType < Types::BaseObject
    field :checkins, [Types::CheckinType], null: false
    field :me, Types::UserType, null: false

    def checkins
      authentication_required
      Checkin.all
    end

    def me
      authentication_required
      context[:current_user]
    end

    private

    def authentication_required
      return if context[:current_user].present?
      raise GraphQL::ExecutionError, 'Authentication required'
    end
  end
end
