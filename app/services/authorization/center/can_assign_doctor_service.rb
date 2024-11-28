class Authorization::Center::CanAssignDoctorService < Authorization::Base
  def initialize(current_doctor:, center_id:, assignee_doctor_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @assignee_doctor_id = assignee_doctor_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_manager_different_from_assignee
  end

  private

  def is_manager_different_from_assignee
    @current_doctor.id.to_s != @assignee_doctor_id.to_s
  end
end
