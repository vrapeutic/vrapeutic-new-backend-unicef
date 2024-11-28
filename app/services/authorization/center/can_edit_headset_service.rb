class Authorization::Center::CanEditHeadsetService < Authorization::Base
  def initialize(current_doctor:, center_id:, headset_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @headset_id = headset_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && center_has_headset?
  end

  private

  def center_has_headset?
    Center::HasHeadsetService.new(center_id: @center_id, headset_id: @headset_id).call
  end
end
