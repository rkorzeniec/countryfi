# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

gem 'rails', '6.1.4.4'

gem 'bootsnap', '~> 1.10.2', require: false
gem 'dalli', '~> 3.2.0'
gem 'devise', '~> 4.8.1'
gem 'devise-async', '~> 1.0.0'
gem 'dotenv-rails', '~> 2.7.6'
gem 'graphql', '~> 1.13.6'
gem 'jwt', '~> 2.3.0'
gem 'mysql2', '~> 0.5.3'
gem 'newrelic_rpm', '~> 8.4.0'
gem 'rack-attack', '~> 6.5.0'
gem 'sentry-raven', '~> 3.1.2'

gem 'administrate', '~> 0.16.0'
gem 'better_errors', '~> 2.9.1'
gem 'daemons', '~> 1.4.1'
gem 'delayed_job_active_record', '~> 4.1.7'
gem 'haml', '~> 5.2.2'
gem 'jbuilder', '~> 2.11'
gem 'kaminari', '~> 1.2.2'
gem 'sassc-rails', '~> 2.1.2'
gem 'turbo-rails', '~> 1.0'
gem 'uglifier', '~> 4.2.0'
gem 'webpacker', '~> 5.4.3'

gem 'flamegraph', '~> 0.9.5'
gem 'memory_profiler', '~> 1.0.0'
gem 'rack-mini-profiler', '~> 2.3.3'
gem 'stackprof', '~> 0.2.17'

gem 'net-smtp', require: false

group :development, :test do
  gem 'brakeman', '~> 5.2.0'
  gem 'bullet', '~> 7.0.1'
  gem 'byebug', '~> 11.1.3'
  gem 'rspec-rails', '~> 5.1.0'
  gem 'rubycritic', '~> 4.6.1', require: false
  gem 'simplecov'
  gem 'simplecov-console'
end

group :development do
  gem 'binding_of_caller', '~> 1.0.0'
  gem 'capistrano', '~> 3.16', require: false
  gem 'capistrano-delayed-job', '~> 1.0', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', '~> 1.6', require: false
  gem 'capistrano-rvm', require: false
  gem 'graphiql-rails', '~> 1.8.0'
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '~> 3.7'
  gem 'puma', '~> 5.6.0'
  gem 'rack-timeout', '~> 0.6.0'
  gem 'rubocop', '~> 1.25.0', require: false
  gem 'rubocop-performance', '~> 1.13.2', require: false
  gem 'rubocop-rails', '~> 2.13.2', require: false
  gem 'spring', '~> 4.0.0'
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'database_cleaner', '~> 2.0.1'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-graphql_matchers', '~> 1.3.1'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'stub_env'
  gem 'timecop', '~> 0.9.4'
end

gem 'sdoc', '~> 2.3.0', group: :doc
