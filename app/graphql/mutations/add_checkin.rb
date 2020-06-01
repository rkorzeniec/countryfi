# frozen_string_literal: true
module Mutations
  class AddCheckin < BaseMutation
    argument :country_id, Integer, required: true
    argument :checkin_date, String, required: true

    field :checkin, Types::CheckinType, null: false

    def resolve(params)
      authentication_required
      checkin = Checkin.new(params.merge(user: context[:current_user]))
      if checkin.save
        { checkin: checkin }
      else
        GraphQL::ExecutionError.new(checkin.errors.full_messages.to_sentence)
      end
    end
  end
end
