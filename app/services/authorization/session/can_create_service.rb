class Authorization::Session::CanCreateService < Authorization::Base
  def initialize(current_doctor:, child_id:, center_id:, headset_id:)
    @current_doctor = current_doctor
    @child_id = child_id
    @center_id = center_id
    @headset_id = headset_id
  end

  def call
    center_has_headset? &&
      (child_assigned_to_doctor_in_center? || (is_doctor_admin_for_center?(@current_doctor.id,
                                                                           @center_id) && is_child_in_center?(@child_id, @center_id)))
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
end
