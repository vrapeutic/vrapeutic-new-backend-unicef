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
    doctor_center = DoctorCenter.find_by(center_id: @center_id, doctor_id: @doctor_id)

    if doctor_center.present?
      raise 'doctor already been invited' if doctor_center.invited?
      raise 'doctor approved the invitation' if doctor_center.approved?

      doctor_center.update!(status: :invited, invited_by: @current_doctor)
    else
      DoctorCenter.create!(
        center_id: @center_id,
        doctor_id: @doctor_id,
        status: :invited,
        invited_by: @current_doctor
      )
    end
  end
end
