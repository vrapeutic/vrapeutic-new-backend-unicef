class Authorization::Session::CanAddDoctorService < Authorization::Base
  def initialize(current_doctor:, session_id:, added_doctor_id:)
    @current_doctor = current_doctor
    @session_id = session_id
    @added_doctor_id = added_doctor_id
  end

  def call
    set_session_center_and_child

    current_doctor_is_not_added_doctor? && is_doctor_in_session?(@current_doctor.id, @session_id) &&
      is_doctor_has_child_in_center?(@added_doctor_id, @child_id, @center_id)
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
end
