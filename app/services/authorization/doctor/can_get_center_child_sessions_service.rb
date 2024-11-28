class Authorization::Doctor::CanGetCenterChildSessionsService < Authorization::Base
  def initialize(current_doctor:, center_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @child_id = child_id
    @roles = DoctorCenter.roles.keys
  end

  def call
    is_doctor_role_in_center?(@current_doctor.id, @center_id, @roles) &&
      (is_doctor_admin_for_center?(@current_doctor.id, @center_id) ||
      is_doctor_has_child_in_center?(@current_doctor.id, @child_id, @center_id))
  end
end
