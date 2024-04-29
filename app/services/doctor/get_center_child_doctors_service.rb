class Doctor::GetCenterChildDoctorsService
  def initialize(child_id:, center_id:, current_doctor:)
    @center_id = center_id
    @child_id = child_id
    @current_doctor = current_doctor
  end

  def call
    center_child_doctors
  end

  private

  def center_child_doctors
    Child::GetAssignedDoctorsInCenterService.new(child_id: @child_id, center_id: @center_id, excluded_doctors_ids: [@current_doctor.id]).call
  end
end
