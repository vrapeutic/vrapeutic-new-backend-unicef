class Authorization::Center::CanAssignModuleToChildService < Authorization::Base
  def initialize(current_doctor:, center_id:, software_module_id:, child_id:)
    @current_doctor = current_doctor
    @center_id = center_id
    @software_module_id = software_module_id
    @child_id = child_id
  end

  def call
    is_doctor_admin_for_center?(@current_doctor.id, @center_id) && is_child_in_center?(@child_id, @center_id) && center_has_module?
  end

  private

  def center_has_module?
    Center::HasModuleService.new(center_id: @center_id, software_module_id: @software_module_id).call
  end
end
