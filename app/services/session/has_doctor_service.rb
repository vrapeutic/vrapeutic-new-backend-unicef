class Session::HasDoctorService

    def initialize(session_id: ,doctor_id:)
        @session_id = session_id
        @doctor_id = doctor_id
    end

    def call 
        session_has_doctor?
    end

    private

    def session_has_doctor?
        SessionDoctor.find_by(session_id: @session_id, doctor_id: @doctor_id).present? ? true : false
    end
end