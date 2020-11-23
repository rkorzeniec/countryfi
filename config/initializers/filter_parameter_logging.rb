# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += %i[
  email
  password
  password_confirmation
  token
  payload
  query
  mutation
  auth_token
  authentication_token
]
