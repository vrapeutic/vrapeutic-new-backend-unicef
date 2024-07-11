class Authorization::Admin::CanEditDoctorService
  def initialize(doctor_id:)
    @doctor_id = doctor_id
  end

  def call
    is_doctor_is_worker
  end

  private

  def is_doctor_is_worker
    DoctorCenter.find_by(doctor_id: @doctor_id, role: 'worker').present? ? true : false
  end
end
