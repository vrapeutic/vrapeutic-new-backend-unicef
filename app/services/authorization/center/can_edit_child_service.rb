class Authorization::Center::CanEditChildService < Authorization::Base
  def initialize(current_doctor:, center_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @child_id = child_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_child_in_center?(@child_id, @center_id)
  end
end
