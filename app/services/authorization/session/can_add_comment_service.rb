class Authorization::Session::CanAddCommentService

    def initialize(current_doctor:, session_id:)
        @current_doctor = current_doctor
        @session_id = session_id
    end

    def call 
        is_doctor_in_session?
    end

    private

    def is_doctor_in_session? 
        Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
    end
end