class Authorization::Session::CanAddAttachmentService
  def initialize(current_doctor:, session_id:)
    @current_doctor = current_doctor
    @session_id = session_id
  end

  def call
    set_session
    is_doctor_in_session?
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
end
