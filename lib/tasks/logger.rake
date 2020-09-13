# frozen_string_literal: true

desc 'Enable STDOUT logging for other rake tasks'
task logger_stdout: :environment do
  logger = Logger.new($stdout)
  logger.level = Logger::INFO
  Rails.logger = logger
end
