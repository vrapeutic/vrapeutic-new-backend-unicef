class Authorization::Center::CanAssignModuleToChildService

    def initialize(current_doctor:, center_id:, software_module_id:, child_id:)
        @current_doctor = current_doctor
        @center_id = center_id
        @software_module_id = software_module_id
        @child_id = child_id
    end

    def call 
        is_current_doctor_admin && is_child_in_center && center_has_module?
    end

    private

    def is_current_doctor_admin
        Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
    end


    def is_child_in_center
        Center::HasChildService.new(child_id: @child_id, center_id: @center_id).call
    end

    def center_has_module? 
        Center::HasModuleService.new(center_id: @center_id, software_module_id: @software_module_id).call
    end
end