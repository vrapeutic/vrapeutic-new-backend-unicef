class Authorization::Center::CanGetAssignedModulesService
  def initialize(current_doctor:, center_id:)
    @current_doctor = current_doctor
    @center_id = center_id
  end

  def call
    is_current_doctor_admin
  end

  private

  def is_current_doctor_admin
    Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
  end
end
