class Center::AssignedModulesService
  # get all modules assigned to center by super admin

  def initialize(center:)
    @center = center
  end

  def call
    asssigned_modules
  end

  private

  def asssigned_modules
    modules_id = @center.assigned_center_modules.where('end_date > ?', Time.now).select(:software_module_id)
    SoftwareModule.where(id: modules_id).includes(:targeted_skills)
  end
end
