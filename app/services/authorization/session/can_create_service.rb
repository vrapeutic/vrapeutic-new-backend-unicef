class Authorization::Session::CanCreateService
  def initialize(current_doctor:, child_id:, center_id:, headset_id:)
    @current_doctor = current_doctor
    @child_id = child_id
    @center_id = center_id
    @headset_id = headset_id
  end

  def call
    center_has_headset? &&
      (child_assigned_to_doctor_in_center? || (is_current_doctor_admin && is_child_in_center))
  end

  private

  # check if this headset in center
  def center_has_headset?
    Center::HasHeadsetService.new(center_id: @center_id, headset_id: @headset_id).call
  end

  # check if child is assigned before to assignee doctor in this center
  def child_assigned_to_doctor_in_center?
    Child::HasDoctorInCenterService.new(doctor_id: @current_doctor.id, child_id: @child_id, center_id: @center_id).call
  end

  def is_current_doctor_admin
    Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
  end

  def is_child_in_center
    Center::HasChildService.new(child_id: @child_id, center_id: @center_id).call
  end
end
