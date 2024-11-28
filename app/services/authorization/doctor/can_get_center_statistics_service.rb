class Authorization::Doctor::CanGetCenterStatisticsService < Authorization::Base
  def initialize(current_doctor:, center_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @roles = DoctorCenter.roles.keys
  end

  def call
    doctor_work_in_center?
  end

  private

  def doctor_work_in_center?
    Center::FindDoctorByRoleService.new(current_doctor_id: @current_doctor.id, center_id: @center_id, role: @roles).call
  end
end
