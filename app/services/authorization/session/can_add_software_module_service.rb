class Authorization::Session::CanAddSoftwareModuleService < Authorization::Base
  def initialize(current_doctor:, session_id:, software_module_id:)
    @current_doctor = current_doctor
    @session_id = session_id
    @software_module_id = software_module_id
  end

  def call
    set_session_center_and_child

    is_doctor_in_session?(@current_doctor.id, @session_id) && child_has_module?
  end

  private

  def set_session_center_and_child
    @session = Session.find(@session_id)
    @center_id = @session.center_id
    @child_id = @session.child_id
  end

  # check if this module is assigned to this child in this center
  def child_has_module?
    Child::HasModuleInCenterService.new(child_id: @child_id, software_module_id: @software_module_id, center_id: @center_id).call
  end
end
