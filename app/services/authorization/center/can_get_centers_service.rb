class Authorization::Center::CanGetCentersService < Authorization::Base
  def initialize(current_doctor:, center_id:)
    @doctor_id = current_doctor.id
    @center_id = center_id
  end

  def call
    is_doctor_admin_for_center?(@doctor_id, @center_id)
  end
end
