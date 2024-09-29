# config/initializers/sidekiq.rb
schedule_file = 'config/schedule.yml'

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?

redis_url = Rails.env.development? ? 'redis://localhost:6379' : ENV['REDIS_URL']

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end