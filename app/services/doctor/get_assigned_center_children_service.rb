class Doctor::GetAssignedCenterChildrenService
  def initialize(doctor:, center_id:)
    @doctor = doctor
    @center_id = center_id
  end

  def call
    assigned_children_in_center
  end

  private

  def assigned_children_in_center
    @doctor.children.where(child_doctors: { center_id: @center_id })
  end
end
