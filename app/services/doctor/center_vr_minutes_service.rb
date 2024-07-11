class Doctor::CenterVrMinutesService
  def initialize(doctor:, center_id:, year: Time.zone.now.year)
    @doctor = doctor
    @center_id = center_id
    @year = year
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
             .where(created_at: "#{@year}-01-01".."#{@year}-12-31")
             .select("DATE_TRUNC('month', sessions.created_at) AS month", 'SUM(sessions.vr_duration) AS total_vr_duration')
             .group("DATE_TRUNC('month', sessions.created_at)")
             .order('month')

    months_hash = Date::MONTHNAMES.drop(1).map { |month| { "#{month} #{@year}" => 0 } }.reduce(:merge)

    result.each do |res|
      month_name = res.month.strftime('%B %Y') # Format the month as "Month Year"
      months_hash[month_name.to_s] = res.total_vr_duration || 0
    end

    months_hash
  end
end
