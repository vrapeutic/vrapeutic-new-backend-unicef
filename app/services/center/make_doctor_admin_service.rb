class Center::MakeDoctorAdminService

    def initialize(doctor_id:, center_id:)
        @doctor_id = doctor_id
        @center_id = center_id
    end

    def call 
        make_doctor_admin
    end

    private

    def make_doctor_admin 
        doctor_center_role = DoctorCenter.find_by(doctor_id: @doctor_id, center_id: @center_id, role: 'worker')
        doctor_center_role.update!(role: 'admin')
    end
end