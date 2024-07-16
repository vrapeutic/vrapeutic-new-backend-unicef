redis_url = Rails.env.development? ? 'redis://localhost:6379' : ENV['REDIS_URL']

REDIS = Redis.new(url: redis_url) unless redis_url.nil?
