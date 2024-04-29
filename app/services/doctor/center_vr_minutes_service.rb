class Doctor::CenterVrMinutesService
  def initialize(doctor:, center_id:)
    @doctor = doctor
    @center_id = center_id
  end

  def call
    set_center
    doctor_sessions
    center_vr_minutes_per_month
  end

  private

  def set_center
    @center = Center.find(@center_id)
  end

  # if admin return all center sessions or return only doctor sessions if doctor is normal worker
  def doctor_sessions
    @sessions = Doctor::CenterSessionsService.new(doctor: @doctor, center: @center).call
  end

  def center_vr_minutes_per_month
    result = @sessions
             .select("DATE_TRUNC('month', sessions.created_at) AS month", 'SUM(sessions.vr_duration) AS total_vr_duration')
             .group("DATE_TRUNC('month', sessions.created_at)")
             .order('month')

    result.map do |res|
      month_name = res.month.strftime('%B %Y') # Format the month as "Month Year"
      [month_name, res.total_vr_duration]
    end
      .to_h
  end
end
