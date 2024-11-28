class Authorization::Admin::CanEditDoctorService < Authorization::Base
  def initialize(doctor_id:)
    @doctor_id = doctor_id
  end

  def call
    is_doctor_is_worker?(@doctor_id)
  end
end
