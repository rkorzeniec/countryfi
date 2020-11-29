# frozen_string_literal: true

namespace :countries do
  desc 'Import countries data'
  task import: :logger_stdout do
    source = Dir.glob(Rails.root.join('lib/countries/source/*.yml')).max

    Rails.logger.info(source)
    Countries::DataUpdater.new(source).call
  end
end
