Raven.configure do |config|
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w[production]
  config.async = ->(event) { SentryJob.perform_later(event) }
end
