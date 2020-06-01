# frozen_string_literal: true
module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    private

    def authentication_required
      return if context[:current_user].present?
      raise GraphQL::ExecutionError, 'Authentication required'
    end
  end
end
