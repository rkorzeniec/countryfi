# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :authenticate_user!

  def execute
    query = params[:query]
    result = CountryfierSchema.execute(query, schema_hash)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def schema_hash
    {
      variables: ensure_hash(params[:variables]),
      context: context,
      operation_name: params[:operationName]
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def context
    { current_user: current_user }
  end

  def current_user
    return if request.headers['Authorization'].blank?

    token = request.headers['Authorization'].split(' ').last
    Graphql::Authenticator.new(token).call
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: {
      error: { message: error.message, backtrace: error.backtrace }, data: {}
    }, status: :internal_server_error
  end
end
