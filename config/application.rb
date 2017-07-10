require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CountryDiary
  class Application < Rails::Application
    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/app/decorators
      #{config.root}/app/formatters
      #{config.root}/app/queries
      #{config.root}/app/facades
    )
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Bern'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [
      :password, :password_confirmation, :auth_token, :authentication_token
    ]

    # Set forgery_protection to false to allow posting to url
    config.action_controller.allow_forgery_protection = true

    # Enable the asset pipeline
    config.assets.enabled = true

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.3'

    # Make sure we precompile separately the javascripts that are called in specific places
    config.assets.precompile += [
      '*.svg',
      '*.eot',
      '*.woff',
      '*.woff2',
      '*.ttf',
      '*.png'
    ]

    config.action_controller.include_all_helpers = true

    # config.to_prepare do
    #   Devise::SessionsController.layout('application_non_menu')
    # end
  end
end
