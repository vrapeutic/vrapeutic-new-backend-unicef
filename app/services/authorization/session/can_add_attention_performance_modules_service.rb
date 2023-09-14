class Authorization::Session::CanAddAttentionPerformanceModulesService

    def initialize(current_doctor:, session_id:)
        @current_doctor = current_doctor
        @session_id = session_id
    end

    def call 
        get_session
        session_is_verified? && is_doctor_in_session? 
    end

    private

    def get_session 
        @session = Session.find(@session_id)
    end

    def session_is_verified? 
        @session.is_verified
    end

    def is_doctor_in_session? 
        Session::HasDoctorService.new(session_id: @session_id, doctor_id: @current_doctor.id).call
    end

end