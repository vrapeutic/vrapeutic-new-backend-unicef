class Authorization::Session::CanAddCommentService < Authorization::Base
  def initialize(current_doctor:, session_id:)
    @current_doctor = current_doctor
    @session_id = session_id
  end

  def call
    is_doctor_in_session?(@current_doctor.id, @session_id)
  end
end
