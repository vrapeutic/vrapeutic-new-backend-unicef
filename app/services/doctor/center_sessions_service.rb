class Doctor::CenterSessionsService
  def initialize(doctor:, center:)
    @doctor = doctor
    @center = center
  end

  def call
    is_doctor_admin?
    doctor_sessions
    @sessions
  end

  private

  def is_doctor_admin?
    @is_doctor_admin = Center::IsDoctorAdminService.new(current_doctor_id: @doctor.id, center_id: @center_id).call
  end

  # if admin return all center sessions or return only doctor sessions if doctor is normal worker
  def doctor_sessions
    @sessions = if @is_doctor_admin
                  @center.sessions
                else
                  @doctor.sessions.where(center_id: @center.id)
                end
  end
end
