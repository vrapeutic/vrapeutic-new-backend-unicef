class Authorization::Center::CanUpdateService

    def initialize(current_doctor:, center_id:)
        @current_doctor = current_doctor
        @center_id = center_id
    end

    def call 
        can_update_center
    end

    private

    def can_update_center
        DoctorCenter.find_by(doctor: @current_doctor, center_id: @center_id, role: 'admin').present? ? true : false
    end
end