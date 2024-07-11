module JsonWebToken
  require 'jwt'
  JWT_SECRET = ENV['JWT_SECRET'] || 'secret-test'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, JWT_SECRET)
    return false unless body

    HashWithIndifferentAccess.new body[0]
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    false
  end
end
