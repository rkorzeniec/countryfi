require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Raven.configure do |config|
  config.dsn = "https://#{ENV['SENTRY_PUBLIC_KEY']}:#{ENV['SENTRY_PRIVATE_KEY']}@sentry.io/#{ENV['SENTRY_PROJECT_ID']}"
end

module Countryfier
  class Application < Rails::Application
    config.autoload_paths += %W[
      #{config.root}/lib
      #{config.root}/app/decorators
      #{config.root}/app/formatters
      #{config.root}/app/queries
      #{config.root}/app/facades
    ]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Bern'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Set forgery_protection to false to allow posting to url
    config.action_controller.allow_forgery_protection = true

    # Enable the asset pipeline
    config.assets.enabled = true

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    config.assets.precompile += [
      '*.json',
      '*.svg',
      '*.eot',
      '*.woff',
      '*.woff2',
      '*.ttf',
      '*.png'
    ]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    config.action_controller.include_all_helpers = true

    # config.to_prepare do
    #   Devise::SessionsController.layout('application_non_menu')
    # end

    config.filter_parameters += %i[password password_confirmation query]

    config.skylight.environments = ['production']
  end
end
