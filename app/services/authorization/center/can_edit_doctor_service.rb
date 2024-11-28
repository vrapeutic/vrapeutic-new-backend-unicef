class Authorization::Center::CanEditDoctorService < Authorization::Base
  def initialize(current_doctor:, center_id:, doctor_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @doctor_id = doctor_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_worker_doctor_in_center
  end

  private

  def is_worker_doctor_in_center
    Center::IsDoctorWorkerService.new(current_doctor_id: @doctor_id, center_id: @center_id).call
  end
end
