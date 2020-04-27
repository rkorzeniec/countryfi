if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = lambda(_context) do
    "bearer #{ENV['JWT_TOKEN']}"
  end
end
