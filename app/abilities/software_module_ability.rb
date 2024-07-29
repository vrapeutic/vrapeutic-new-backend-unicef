class SoftwareModuleAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]
    when 'index'
      can :index, SoftwareModule if Authorization::Center::CanGetModulesService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, SoftwareModule if Authorization::Center::CanGetModulesService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'assigned_modules'
      can :assigned_modules, SoftwareModule if Authorization::Center::CanGetAssignedModulesService.new(
        current_doctor: doctor,
        center_id: params[:center_id]
      ).call
    when 'add_modules'
      can :add_modules, SoftwareModule if Authorization::Center::CanAddModulesService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'assign_module_child'
      can :assign_module_child, SoftwareModule if Authorization::Center::CanAssignModuleToChildService.new(
        current_doctor: doctor,
        center_id: params[:center_id],
        software_module_id: params[:id],
        child_id: params[:child_id]
      ).call
    when 'unassign_module_child'
      can :unassign_module_child, SoftwareModule if Authorization::Center::CanUnassignModuleFromChildService.new(
        current_doctor: doctor,
        center_id: params[:center_id],
        software_module_id: params[:id],
        child_id: params[:child_id]
      ).call
    else
      false
    end
  end
end
