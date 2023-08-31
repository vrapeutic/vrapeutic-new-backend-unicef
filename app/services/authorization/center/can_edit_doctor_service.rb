class Authorization::Center::CanEditDoctorService

    def initialize(current_doctor:, center_id:, doctor_id:)
        @current_doctor = current_doctor
        @center_id = center_id
        @doctor_id = doctor_id
    end

    def call 
        is_current_doctor_admin && is_worker_doctor_in_center
    end

    private

    # check if current doctor is manager to this center and the worker doctor is working in this center
    def is_current_doctor_admin
        Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
    end

    def is_worker_doctor_in_center
        Center::IsDoctorWorkerService.new(current_doctor_id: @doctor_id, center_id: @center_id).call
    end
end