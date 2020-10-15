# frozen_string_literal: true

class CountryfierSchema < GraphQL::Schema
  disable_introspection_entry_points if Rails.env.production?

  query(Types::QueryType)
  mutation(Types::MutationType)
end
