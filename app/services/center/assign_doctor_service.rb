class Center::AssignDoctorService
  def initialize(doctor_id:, center_id:, current_doctor:)
    @doctor_id = doctor_id
    @center_id = center_id
    @current_doctor = current_doctor
  end

  def call
    create_doctor_center_role
  end

  private

  def create_doctor_center_role
    DoctorCenter.create!(
      center_id: @center_id,
      doctor_id: @doctor_id,
      status: :invited,
      invite_by: @current_doctor
    )
  end
end
