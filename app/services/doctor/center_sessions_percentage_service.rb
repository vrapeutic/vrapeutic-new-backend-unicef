class Doctor::CenterSessionsPercentageService
  def initialize(doctor:, center_id:)
    @doctor = doctor
    @center_id = center_id
  end

  def call
    set_center
    doctor_sessions
    sessions_percentage
  end

  private

  def set_center
    @center = Center.find(@center_id)
  end

  # if admin return all center sessions or return only doctor sessions if doctor is normal worker
  def doctor_sessions
    @sessions = Doctor::CenterSessionsService.new(doctor: @doctor, center: @center).call
  end

  def sessions_percentage
    today_sessions = @sessions.where('DATE(sessions.created_at) = ?', Date.today).count
    yeterday_sessions = @sessions.where('DATE(sessions.created_at) = ?', Date.yesterday).count
    percentage = if yeterday_sessions.positive?
                   ((today_sessions.to_f - yeterday_sessions) / yeterday_sessions) * 100
                 else
                   today_sessions * 100
                 end
    {
      today_sessions: today_sessions,
      yeterday_sessions: yeterday_sessions,
      percentage: percentage
    }
  end
end
