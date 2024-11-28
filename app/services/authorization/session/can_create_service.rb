class Authorization::Session::CanCreateService < Authorization::Base
  def initialize(current_doctor:, child_id:, center_id:, headset_id:)
    @current_doctor = current_doctor
    @child_id = child_id
    @center_id = center_id
    @headset_id = headset_id
  end

  def call
    center_has_headset? &&
      (is_doctor_has_child_in_center?(@current_doctor.id, @child_id, @center_id) ||
      (is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_child_in_center?(@child_id, @center_id)))
  end

  private

  # check if this headset in center
  def center_has_headset?
    Center::HasHeadsetService.new(center_id: @center_id, headset_id: @headset_id).call
  end
end
