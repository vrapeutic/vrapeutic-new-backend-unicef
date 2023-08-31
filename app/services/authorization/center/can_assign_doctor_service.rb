class Authorization::Center::CanAssignDoctorService
    def initialize(current_doctor:, center_id:, assignee_doctor_id:)
        @current_doctor = current_doctor
        @center_id = center_id
        @assignee_doctor_id = assignee_doctor_id
    end

    def call 
        is_current_doctor_admin && is_manager_different_from_assignee
    end

    private

    def is_current_doctor_admin
        Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
    end

    def is_manager_different_from_assignee
        @current_doctor.id.to_s == @assignee_doctor_id.to_s ? false : true
    end
end