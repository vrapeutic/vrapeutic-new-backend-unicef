class Authorization::Session::CanResendOtpService

    def initialize(current_doctor:, session_id:)
        @current_doctor = current_doctor
        @session_id = session_id
    end

    def call 
        session_has_doctor?
    end

    private


    def session_has_doctor? 
        Session::HasDoctorService.new(session_id: @session_id,doctor_id: @current_doctor.id).call
    end
end