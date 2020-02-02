module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    private

    def authentication_required
      return if context[:current_user].present?
      raise GraphQL::ExecutionError.new('Authentication required')
    end
  end
end
