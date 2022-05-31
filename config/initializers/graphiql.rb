# frozen_string_literal: true

if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] =
    ->(_context) { "bearer #{ENV.fetch('JWT_TOKEN')}" }
end
