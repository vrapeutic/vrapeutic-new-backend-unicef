class Doctor::CenterKidsService
  def initialize(doctor:, center:)
    @doctor = doctor
    @center = center
  end

  def call
    is_doctor_admin?
    doctor_kids
    @children
  end

  private

  def is_doctor_admin?
    @is_doctor_admin = Center::IsDoctorAdminService.new(current_doctor_id: @doctor.id, center_id: @center.id).call
  end

  # if admin return all center sessions or return only doctor sessions if doctor is normal worker
  def doctor_kids
    @children = if @is_doctor_admin
                  @center.children
                else
                  Doctor::GetAssignedCenterChildrenService.new(doctor: @doctor, center_id: @center.id).call
                end
  end
end
