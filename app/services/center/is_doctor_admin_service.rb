class Center::IsDoctorAdminService
  def initialize(current_doctor_id:, center_id:)
    @current_doctor_id = current_doctor_id
    @center_id = center_id
  end

  def call
    Center::FindDoctorByRoleService.new(current_doctor_id: @current_doctor_id, center_id: @center_id, role: 'admin').call
  end
end
