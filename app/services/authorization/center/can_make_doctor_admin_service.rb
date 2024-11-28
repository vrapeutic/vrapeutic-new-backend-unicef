class Authorization::Center::CanMakeDoctorAdminService < Authorization::Base
  def initialize(current_doctor:, center_id:, worker_doctor_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @worker_doctor_id = worker_doctor_id
    @roles = %w[worker]
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_doctor_role_in_center?(@worker_doctor_id, @center_id, @roles)
  end
end
