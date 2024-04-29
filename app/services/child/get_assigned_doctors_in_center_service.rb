class Child::GetAssignedDoctorsInCenterService
  def initialize(child_id:, center_id:, excluded_doctors_ids: [])
    @center_id = center_id
    @child_id = child_id
    @excluded_doctors_ids = excluded_doctors_ids
  end

  def call
    set_assigned_doctors_in_center
  end

  private

  def set_assigned_doctors_in_center
    child = Child.find(@child_id)
    child.doctors.where(child_doctors: { center_id: @center_id }).where.not(id: @excluded_doctors_ids)
  end
end
