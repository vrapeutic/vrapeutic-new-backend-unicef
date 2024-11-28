class Authorization::Session::CanAddDoctorService < Authorization::Base
  def initialize(current_doctor:, session_id:, added_doctor_id:)
    @current_doctor = current_doctor
    @session_id = session_id
    @added_doctor_id = added_doctor_id
  end

  def call
    set_session_center_and_child
    current_doctor_is_not_added_doctor? && session_has_doctor? && child_assigned_to_doctor_in_center?
  end

  private

  def set_session_center_and_child
    @session = Session.find(@session_id)
    @center_id = @session.center_id
    @child_id = @session.child_id
  end

  def current_doctor_is_not_added_doctor?
    @current_doctor.id.to_s != @added_doctor_id.to_s
  end

  def session_is_verified?
    @session.is_verified
  end

  # check if this doctor in session
  def session_has_doctor?
    Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
  end

  # check if child is assigned before to this added doctor in this center
  def child_assigned_to_doctor_in_center?
    Child::HasDoctorInCenterService.new(doctor_id: @added_doctor_id, child_id: @child_id, center_id: @center_id).call
  end
end
