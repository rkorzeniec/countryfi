# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start 'rails'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end

require 'spec_helper'
require 'rspec/rails'
require 'devise'
require 'factory_bot'

rails_root = Rails.root

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.filter_run_excluding migrations: true
  config.filter_run_excluding broken: true

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.filter_rails_from_backtrace!

  config.render_views = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.clean
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
    # FileUtils.rm_rf(Dir["#{rails_root}/spec/support/uploads"])
  end

  config.fixture_path = "#{rails_root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include ApplicationHelper, type: :controller
  config.include FactoryBot::Syntax::Methods

  config.around(:each, :migration) do |example|
    ActiveRecord::Migration.verbose = false
    example.run
    ActiveRecord::Migration.verbose = true
  end

  # config.around(:each) { |example| I18n.with_locale(:de) { example.run } }
end
