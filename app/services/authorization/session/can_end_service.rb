class Authorization::Session::CanEndService < Authorization::Base
  def initialize(current_doctor:, session_id:)
    @current_doctor = current_doctor
    @session_id = session_id
  end

  def call
    set_session
    session_has_doctor?
  end

  private

  def set_session
    @session = Session.find(@session_id)
  end

  def session_is_verified?
    @session.is_verified
  end

  # check if this doctor in session
  def session_has_doctor?
    Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
  end
end
