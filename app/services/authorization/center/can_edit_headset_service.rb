class Authorization::Center::CanEditHeadsetService
  def initialize(current_doctor:, center_id:, headset_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @headset_id = headset_id
  end

  def call
    is_current_doctor_admin && center_has_headset?
  end

  private

  def is_current_doctor_admin
    Center::IsDoctorAdminService.new(current_doctor_id: @current_doctor.id, center_id: @center_id).call
  end

  def center_has_headset?
    Center::HasHeadsetService.new(center_id: @center_id, headset_id: @headset_id).call
  end
end
