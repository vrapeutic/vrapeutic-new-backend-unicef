class Authorization::Center::CanUnassignDoctorFromChildService < Authorization::Base
  def initialize(current_doctor:, child_id:, center_id:, assignee_doctor_id:)
    @current_doctor = current_doctor
    @child_id = child_id
    @center_id = center_id
    @assignee_doctor_id = assignee_doctor_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && child_assigned_to_doctor_in_center?
  end

  private

  # check if child is assigned before to assignee doctor in this center
  def child_assigned_to_doctor_in_center?
    Child::HasDoctorInCenterService.new(doctor_id: @assignee_doctor_id, child_id: @child_id, center_id: @center_id).call
  end
end
