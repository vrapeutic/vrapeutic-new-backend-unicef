class Center::HasAssignedModulesService
  # check if super admin has assigned theses modules to this center

  def initialize(center_id:, software_module_ids:)
    @center_id = center_id
    @software_module_ids = software_module_ids
  end

  def call
    modules_assigned_to_center?
  end

  private

  def modules_assigned_to_center?
    result = AssignedCenterModule.where(center_id: @center_id, software_module_id: @software_module_ids).where('end_date > ?',
                                                                                                               AssignedCenterModule::END_DATE)

    result.count.positive?
  end
end
