class JwtToken
  SECRET = Rails.application.secrets.jwt_secret_key_base.to_s.freeze
  private_constant :SECRET

  class << self
    def token(payload)
      payload['iat'] = Time.current.to_i
      JWT.encode(payload, SECRET)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET).first
      HashWithIndifferentAccess.new(decoded)
    end
  end
end
