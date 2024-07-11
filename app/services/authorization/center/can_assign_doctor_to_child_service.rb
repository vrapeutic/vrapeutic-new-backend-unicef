class Authorization::Center::CanAssignDoctorToChildService
  def initialize(current_doctor:, center_id:, assignee_doctor_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @assignee_doctor_id = assignee_doctor_id
    @child_id = child_id
    @roles = %w[admin worker]
  end

  def call
    is_current_doctor_admin && is_child_in_center && assignee_doctor_works_in_center?
  end

  private

  def is_current_doctor_admin
    Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
  end

  def is_child_in_center
    Center::HasChildService.new(child_id: @child_id, center_id: @center_id).call
  end

  # check if assigness doctor is admin or worker in this center
  def assignee_doctor_works_in_center?
    Center::FindDoctorByRoleService.new(current_doctor_id: @assignee_doctor_id, center_id: @center_id, role: @roles).call
  end
end
