if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = lambda do
    "bearer #{ENV['JWT_TOKEN']}"
  end
end
