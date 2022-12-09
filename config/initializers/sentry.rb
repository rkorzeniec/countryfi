# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', nil)
  config.enabled_environments = %w[production]

  config.rails.report_rescued_exceptions = true
  config.breadcrumbs_logger = %i[sentry_logger http_logger active_support_logger]

  config.async = ->(event) { SentryJob.perform_later(event) }

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  # config.traces_sample_rate = 1.0
  # or
  # config.traces_sampler = lambda do |context|
  #   0.5
  # end
end
