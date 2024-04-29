class SoftwareModuleAbility
  include CanCan::Ability

  def initialize(doctor, params)
    case params[:action]
    when 'index'
      can :index, SoftwareModule if Authorization::Center::CanGetModulesService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'show'
      can :show, SoftwareModule if Authorization::Center::CanGetModulesService.new(current_doctor: doctor, center_id: params[:center_id]).call
    when 'assigned_modules'
      can :assigned_modules, SoftwareModule if Authorization::Center::CanGetAssignedModulesService.new(current_doctor: doctor,
                                                                                                       center_id: params[:center_id]).call
    else
      false
    end
  end
end
