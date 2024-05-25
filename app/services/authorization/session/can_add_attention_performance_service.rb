class Authorization::Session::CanAddAttentionPerformanceService
  def initialize(current_doctor:, session_id:, software_module_id:)
    @current_doctor = current_doctor
    @session_id = session_id
    @software_module_id = software_module_id
  end

  def call
    set_session
    is_doctor_in_session? && session_has_module?
  end

  private

  def set_session
    @session = Session.find(@session_id)
  end

  def session_is_verified?
    @session.is_verified
  end

  def is_doctor_in_session?
    Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
  end

  def session_has_module?
    Session::HasModuleService.new(session_id: @session_id, software_module_id: @software_module_id).call
  end
end
