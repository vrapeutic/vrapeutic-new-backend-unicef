module JsonWebToken
    require 'jwt'
    JWT_SECRET = ENV['ACTION_MAILER_PASSWORD']
  
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, JWT_SECRET)
    end
  
    def self.decode(token)
      begin
        body = JWT.decode(token, JWT_SECRET)
        if body then HashWithIndifferentAccess.new body[0] else return false end
      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        return false
      rescue JWT::DecodeError, JWT::VerificationError => e
        return false
      end
    end
  end
  