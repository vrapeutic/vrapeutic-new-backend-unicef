class FreeBlockedHeadsetWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(session_id)
    session = Session.find(session_id)
    now_time = Time.zone.now
    duration = ((now_time - session.created_at) / 60.0).round(1)

    session.update!(ended_at: now_time, duration: duration) if duration >= 90
  end
end
