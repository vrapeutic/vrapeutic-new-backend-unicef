class Authorization::Center::CanEditDoctorService

    def initialize(current_doctor:, center_id:, doctor_id:)
        @current_doctor = current_doctor
        @center_id = center_id
        @doctor_id = doctor_id
    end

    def call 
        is_current_doctor_center_manager && is_edited_doctor_worker_in_center
    end

    private

    def is_current_doctor_center_manager
        Authorization::Center::CanUpdateService.new(current_doctor: @current_doctor, center_id: @center_id)
    end

    def is_edited_doctor_worker_in_center
        DoctorCenter.find_by(doctor_id: @doctor_id, center_id: @center_id, role: "worker").present? ? true : false
    end
end