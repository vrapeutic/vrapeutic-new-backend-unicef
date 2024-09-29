class FreeSessionsHeadsetWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform
    Session.where(ended_at: nil).find_each(batch_size: 500) do |session|
      now_time = Time.zone.now
      duration = ((now_time - session.created_at) / 60.0).round(1)

      next if duration < 1805

      session.update!(ended_at: now_time, duration: duration)

      sleep 0.001
    end
  end
end
