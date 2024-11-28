class Authorization::Doctor::CanGetCenterStatisticsService < Authorization::Base
  def initialize(current_doctor:, center_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @roles = DoctorCenter.roles.keys
  end

  def call
    is_doctor_role_in_center?(@current_doctor.id, @center_id, @roles)
  end
end
