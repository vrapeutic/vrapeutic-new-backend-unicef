class Center::SessionsVrPercentageService
  def initialize(doctor:, center:, doctor_sessions: nil)
    @doctor = doctor
    @center = center
    @doctor_sessions = doctor_sessions
  end

  def call
    doctor_sessions
    vr_percnetage
  end

  private

  def doctor_sessions
    @sessions = if @doctor_sessions.nil?
                  Doctor::CenterSessionsService.new(doctor: @doctor, center: @center).call
                else
                  @doctor_sessions
                end
  end

  def vr_percnetage
    # Sum up vr_duration and duration for all sessions

    result = @sessions.select('SUM(vr_duration) AS total_vr_duration, SUM(duration) AS total_duration')

    result = result.as_json[0]

    total_vr_duration = result['total_vr_duration'] || 0
    total_duration = result['total_duration'] || 1 # Ensure total_duration is not zero to avoid division by zero

    (total_vr_duration.to_f / total_duration) * 100
  end
end
