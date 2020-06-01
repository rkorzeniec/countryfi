# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    field :signin, mutation: Mutations::Signin
    field :signup, mutation: Mutations::Signup
    field :add_checkin, mutation: Mutations::AddCheckin
  end
end
