class Authorization::Doctor::CanEditProfileService < Authorization::Base
  def initialize(current_doctor:, updated_doctor_id:)
    @current_doctor = current_doctor
    @updated_doctor_id = updated_doctor_id
  end

  def call
    can_edit_profile
  end

  private

  # check if current doctor is the same updated cotor by id
  def can_edit_profile
    @current_doctor.id.to_s == @updated_doctor_id.to_s
  end
end
