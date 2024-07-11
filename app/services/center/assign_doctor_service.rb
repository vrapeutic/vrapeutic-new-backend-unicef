class Center::AssignDoctorService
  def initialize(doctor_id:, center_id:)
    @doctor_id = doctor_id
    @center_id = center_id
  end

  def call
    create_doctor_center_role
  end

  private

  def create_doctor_center_role
    DoctorCenter.create!(center_id: @center_id, doctor_id: @doctor_id)
  end
end
