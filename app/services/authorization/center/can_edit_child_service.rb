class Authorization::Center::CanEditChildService
  def initialize(current_doctor:, center_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @child_id = child_id
  end

  def call
    is_current_doctor_admin && is_child_in_center
  end

  private

  def is_current_doctor_admin
    Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
  end

  def is_child_in_center
    Center::HasChildService.new(child_id: @child_id, center_id: @center_id).call
  end
end
