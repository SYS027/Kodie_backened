require 'jwt'

class JwtService
  def self.generate_token(payload)
    secret_key = Rails.application.secrets.secret_key_base
    JWT.encode(payload, secret_key, 'HS256')
  end
  def self.decode_token(token)
    secret_key = Rails.application.secrets.secret_key_base
    JWT.decode(token, secret_key, true, algorithm: 'HS256')
  end
end