class Session::AddDoctorService
  def initialize(session_id:, doctor_id:)
    @session_id = session_id
    @doctor_id = doctor_id
  end

  def call
    add_doctor_to_session
  end

  private

  def add_doctor_to_session
    SessionDoctor.create!(session_id: @session_id, doctor_id: @doctor_id)
  end
end
