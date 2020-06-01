# frozen_string_literal: true

class CountryfierSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)
end
