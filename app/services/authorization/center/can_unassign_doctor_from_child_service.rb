class Authorization::Center::CanUnassignDoctorFromChildService

    def initialize(current_doctor:, child_id:, center_id:, assignee_doctor_id:)
        @current_doctor = current_doctor
        @child_id = child_id
        @center_id = center_id
        @assignee_doctor_id = assignee_doctor_id
    end

    def  call 
        is_current_doctor_admin && child_assigned_to_doctor_in_center?
    end

    private

    def is_current_doctor_admin
        Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
    end

    # check if child is assigned before to assignee doctor in this center
    def child_assigned_to_doctor_in_center? 
        Child::HasDoctorInCenterService.new(doctor_id: @assignee_doctor_id, child_id: @child_id, center_id:  @center_id).call
    end
end