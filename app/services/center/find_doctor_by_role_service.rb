class Center::FindDoctorByRoleService

    # check if current doctor is admin or worker of this center

    def initialize(current_doctor_id:, center_id:, role:)
        @current_doctor_id = current_doctor_id
        @center_id = center_id
        @role = role
    end

    def call
        check_doctor_has_role_in_center
    end

    private

    def check_doctor_has_role_in_center
        DoctorCenter.find_by(doctor_id: @current_doctor_id, center_id: @center_id, role: @role).present? ? true : false
    end
end
