class Authorization::Doctor::CanGetChildSessionsDataService < Authorization::Base
  def initialize(current_doctor:, center_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @child_id = child_id
    @roles = DoctorCenter.roles.keys
  end

  def call
    return is_child_in_center?(@child_id, @center_id) if is_doctor_admin_for_center?(@current_doctor.id, @center_id)

    is_doctor_role_in_center?(@current_doctor.id, @center_id, @roles) && is_doctor_assigned_to_child?
  end

  private

  def is_doctor_assigned_to_child?
    Child::HasDoctorInCenterService.new(doctor_id: @current_doctor, child_id: @child_id, center_id: @center_id).call
  end
end
