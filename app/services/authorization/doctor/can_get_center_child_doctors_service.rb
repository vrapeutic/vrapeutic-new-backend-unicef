class Authorization::Doctor::CanGetCenterChildDoctorsService

    def initialize(current_doctor:, center_id:, child_id:)
        @current_doctor = current_doctor
        @center_id = center_id
        @child_id = child_id
        @roles = DoctorCenter.roles.keys
    end

    def call 
        doctor_work_in_center? && is_doctor_assigned_to_child?
    end

    private

    def doctor_work_in_center? 
        Center::FindDoctorByRoleService.new(current_doctor_id: @current_doctor.id, center_id: @center_id, role: @roles).call
    end

    def is_doctor_assigned_to_child? 
        Child::HasDoctorInCenterService.new(doctor_id: @current_doctor.id, child_id: @child_id, center_id: @center_id).call
    end
    
end