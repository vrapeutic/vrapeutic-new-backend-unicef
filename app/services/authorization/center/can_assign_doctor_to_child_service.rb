class Authorization::Center::CanAssignDoctorToChildService < Authorization::Base
  def initialize(current_doctor:, center_id:, assignee_doctor_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @assignee_doctor_id = assignee_doctor_id
    @child_id = child_id
    @roles = DoctorCenter.roles.keys
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id,
                                @center_id) && is_child_in_center?(@child_id,
                                                                   @center_id) && is_doctor_role_in_center?(@assignee_doctor_id, @center_id, @roles)
  end
end
