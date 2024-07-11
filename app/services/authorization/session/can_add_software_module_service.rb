class Authorization::Session::CanAddSoftwareModuleService
  def initialize(current_doctor:, session_id:, software_module_id:)
    @current_doctor = current_doctor
    @session_id = session_id
    @software_module_id = software_module_id
  end

  def call
    set_session_center_and_child
    session_has_doctor? && child_has_module?
  end

  private

  def set_session_center_and_child
    @session = Session.find(@session_id)
    @center_id = @session.center_id
    @child_id = @session.child_id
  end

  def session_is_verified?
    @session.is_verified
  end

  # check if this doctor in session
  def session_has_doctor?
    Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
  end

  # check if this module is assigned to this child in this center
  def child_has_module?
    Child::HasModuleInCenterService.new(child_id: @child_id, software_module_id: @software_module_id, center_id: @center_id).call
  end
end
