class Center::AssignDoctorToChildService
  def initialize(assignee_doctor_id:, child_id:, center_id:)
    @assignee_doctor_id = assignee_doctor_id
    @child_id = child_id
    @center_id = center_id
  end

  def call
    assign_doctor_to_child
  end

  private

  def assign_doctor_to_child
    ChildDoctor.create!(child_id: @child_id, doctor_id: @assignee_doctor_id, center_id: @center_id)
  end
end
