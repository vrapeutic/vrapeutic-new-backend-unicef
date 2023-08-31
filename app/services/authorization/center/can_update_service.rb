class Authorization::Center::CanUpdateService

    def initialize(current_doctor:, center_id:)
        @current_doctor = current_doctor
        @center_id = center_id
    end

    def call 
        is_current_doctor_center_manager
    end

    private

    def is_current_doctor_center_manager
        DoctorCenter.find_by(doctor: @current_doctor, center_id: @center_id, role: 'admin').present? ? true : false
    end
end