# frozen_string_literal: true

module Graphql
  class Authenticator
    def initialize(token)
      @token = token
    end

    def call
      return if token.blank?
      decoded_token = JwtToken.decode(token)
      User.find_by(id: decoded_token[:user_id], jti_token: decoded_token[:jti_token])
    end

    private

    attr_reader :token
  end
end
